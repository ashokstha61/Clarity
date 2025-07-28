import 'dart:async';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sleep_less/custom/sound_card.dart';
import 'package:sleep_less/model/sound_model.dart';
import 'timer_screen.dart';

class SoundSelectionPage extends StatefulWidget {
  const SoundSelectionPage({super.key});

  @override
  SoundSelectionPageState createState() => SoundSelectionPageState();
}

class SoundSelectionPageState extends State<SoundSelectionPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isTimerRunning = false;
  String? _selectedSoundUrl;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<SoundModel> sounds = [];

  @override
  void initState() {
    super.initState();
    _fetchSoundsFromFirebase();
  }

  Future<void> _fetchSoundsFromFirebase() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('sounds').get();
      setState(() {
        sounds = snapshot.docs
            .map(
              (doc) => SoundModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList();
      });
    } catch (e) {
      print('Error fetching sounds: $e');
    }
  }

  void _playSound(String soundUrl) async {
    try {
      await audioPlayer.play(UrlSource(soundUrl));
      setState(() {
        _selectedSoundUrl = soundUrl;
      });
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  void _showTimerScreen() {
    showModalBottomSheet(
      context: context,
      builder: (context) => TimerScreen(
        onTimerSelected: (duration) {
          setState(() {
            _remainingSeconds = duration;
            _isTimerRunning = true;
          });
          _startTimer();
        },
      ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
          _isTimerRunning = false;
          audioPlayer.stop();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sound Selection')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: sounds.length,
              itemBuilder: (context, index) {
                final sound = sounds[index];
                return SoundCard(
                  label: sound.title,
                  imagePath: 'assets/images/himage/${sound.filepath}.png',
                  onPressed: () {
                    if (sound.musicURL.isNotEmpty) {
                      _playSound(sound.musicURL);
                    }
                  },
                );
              },
            ),
          ),
          if (_isTimerRunning)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Remaining: ${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _showTimerScreen,
                  child: Text('Set Timer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedSoundUrl != null) {
                      _playSound(_selectedSoundUrl!);
                    }
                  },
                  child: Text('Play'),
                ),
                ElevatedButton(
                  onPressed: () {
                    audioPlayer.stop();
                    setState(() {
                      _selectedSoundUrl = null;
                    });
                  },
                  child: Text('Stop'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
