import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hadeer/Screens/login.dart';


void main() {
  runApp(const HaderApp());
}

class HaderApp extends StatelessWidget {
  const HaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'IBM Plex Sans'),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // مستويات الظهور (Opacity) لكل عنصر
  double _logoOpacity = 0.0;
  double _textOpacity = 0.0;
  double _buttonOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _animateElements();
  }

  // دالة التحكم في تتابع الظهور (Sequence)
  void _animateElements() async {
    // 1. إظهار اللوجو بعد 500 ملي ثانية
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _logoOpacity = 1.0);

    // 2. إظهار النصوص بعد ثانية واحدة من ظهور اللوجو
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _textOpacity = 1.0);

    // 3. إظهار الزر في النهاية بعد ثانية إضافية
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _buttonOpacity = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF005D52), // الخلفية الخضراء الثابتة
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // --- 1. اللوجو ---
            AnimatedOpacity(
              duration: const Duration(seconds: 1), // مدة التلاشي
              opacity: _logoOpacity,
              child: Transform.translate(
                offset: const Offset(0, -70), // رفعه قليلاً للأعلى حسب التصميم
                child: Image.asset(
                  'assets/65.png',
                  width: 380,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // --- 2. النصوص (العنوان والوصف) ---
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _textOpacity,
              child: Transform.translate(
                offset: const Offset(0, 70), // موضعه تحت اللوجو
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Hader Application',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Smart Attendance System For Student',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),

           // --- 3. زر Get Started ---
Positioned(
bottom: 250,
  child: AnimatedOpacity(
    duration: const Duration(seconds: 1),
    opacity: _buttonOpacity,
    child: GestureDetector(
      // هذا هو الجزء المسؤول عن الانتقال
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
child: Container(
        width: 280,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            colors: [Color(0xFFD9D9D9), Colors.white, Color(0xFFD9D9D9)],
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4)),
          ],
        ),
        child: const Center(
          child: Text(
            'Get Started',
            style: TextStyle(
              color : Color(0xFF005D52),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            )
),
),
),
),
),
),
],
),
),
);
  }
}