import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Image.png', height: 160, width: 160),
            const SizedBox(height: 20),
            Text(
              'Clarity'.toUpperCase(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(37, 45, 65, 1),
                fontFamily: 'montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
