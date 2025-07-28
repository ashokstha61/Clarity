import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sleep_less/view/homepage.dart';
import 'package:sleep_less/view/sound_selection_page.dart';
import 'package:sleep_less/view/timer_screen.dart';

// Ensure this file exists from flutterfire configure

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();

    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e'); // Log the error for debugging
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clarity', // Updated title to match app name
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, // Optional: Use Material 3 for modern design
      ),
      home: SoundSelectionPage(), // Start with SoundSelectionPage
    );
  }
}
