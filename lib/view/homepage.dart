import 'package:flutter/material.dart';
import 'package:sleep_less/view/favouratepage.dart';
import 'package:sleep_less/view/profile_page.dart';
import 'package:sleep_less/view/soundpage.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [Soundpage(), Favouratepage(), ProfilePage()];

  final List<String> _titles = ['Sounds', 'Favourites', 'Settings'];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'Recoleta',
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 37, 37, 80),
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.grey,
        unselectedItemColor: const Color.fromARGB(255, 175, 165, 165),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack_outlined),
            label: 'Sound',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
