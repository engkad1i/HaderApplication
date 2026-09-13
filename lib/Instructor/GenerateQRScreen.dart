import 'package:flutter/material.dart';
import 'GenerateQRScreen2.dart';
import 'package:hadeer/Instructor/Dashboard_i.dart';

class GenerateQRScreen extends StatelessWidget {
  const GenerateQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF005D52), Color(0xFF00C3AC)],
            stops: [0.0145, 0.3702],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              width: 277, height: 155, left: 219, top: 10,
              child: Image.asset('assets/65.png', fit: BoxFit.contain),
            ),
            Positioned(
              width: 50, height: 50, left: 43, top: 59,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset('assets/12.png', fit: BoxFit.contain),
              ),
            ),
            Positioned(
              width: screenWidth, height: 811, left: 0, top: 151,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                    stops: [0.0, 0.4375, 0.9279, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    const Positioned(
                      width: 378, top: 48, left: 30,
                      child: Text(
                        'Generate Attendance QR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          color: Color(0xFF005D52),
                          shadows: [Shadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)],
                        ),
                      ),
                    ),

                    // زر Generate QR
                    Positioned(
                      width: 225, height: 50, left: 107, top: 186,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GenerateQRScreen2()),
                          );
                        },
                        child: Container(
                          decoration: _buttonDecoration(),
                          child: const Center(
                            child: Text('Generate QR', style: _buttonTextStyle),
                          ),
                        ),
                      ),
                    ),

                    // زر Done المحدث (الإحداثيات الجديدة)
                    Positioned(
                      width: 150, height: 50, left: 144, top: 645, // 796 - 151
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: _buttonDecoration(borderWidth: 1),
                          child: const Center(
                            child: Text('Done', style: _buttonTextStyle),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// تنسيقات مشتركة للأزرار لضمان نظافة الكود
BoxDecoration _buttonDecoration({double borderWidth = 1}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    gradient: const LinearGradient(
      colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
      stops: [0.0, 0.4375, 0.9279, 1.0],
    ),
    border: Border.all(color: const Color(0x718C8484), width: borderWidth),
    boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)],
  );
}

const _buttonTextStyle = TextStyle(
  fontFamily: 'IBM Plex Sans',
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w500,
  fontSize: 24,
  color: Color(0xFF005D52),
);