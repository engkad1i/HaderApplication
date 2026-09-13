import 'package:flutter/material.dart';
import 'package:hadeer/Student/Dashboard_s.dart';

class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        // الخلفية المتدرجة الأساسية
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
            // --- الشعار العلوي ---
            Positioned(
              width: 277, height: 155, left: 219, top: 10,
              child: Image.asset('assets/65.png', fit: BoxFit.contain),
            ),

            // --- زر العودة ---
            Positioned(
              width: 50, height: 50, left: 43, top: 59,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset('assets/12.png', fit: BoxFit.contain),
              ),
            ),

            // --- الكارت الأبيض الرئيسي (Rectangle 34) ---
            Positioned(
              width: screenWidth,
              height: 811,
              left: 0,
              top: 151,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFD9D9D9),
                      Colors.white,
                      Colors.white,
                      Color(0xFFD9D9D9)
                    ],
                    stops: [0.0, 0.4375, 0.9279, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    // عنوان الصفحة (Alert)
                    const Positioned(
                      width: 378, top: 48, left: 30,
                      child: Text(
                        'Alert',
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

                    // المربع الرمادي الخلفي (Rectangle 35)
                    Positioned(
                      width: 370, height: 300, left: 34, top: 208,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(40),
                          border: const Border(top: BorderSide(color: Color(0x4A3C3C43), width: 2)),
                          boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)],
                        ),
                      ),
                    ),

                    // --- التعديل المحدث: مكان صورة Danger Triangle ---
                    Positioned(
                      width: 130, 
                      height: 130, 
                      left: 158, 
                      top: 228, // الحساب: 379 (Figma) - 151 (بداية الكارت) = 228
                      child: Image.asset(
                        'assets/14.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    // --- التعديل المحدث: مكان نص التحذير ---
                    Positioned(
                      width: 225, 
                      height: 105, 
                      left: 107, 
                      top: 359, // الحساب: 510 (Figma) - 151 (بداية الكارت) = 359
                      child: const Text(
                        'Warning Percentage has reached 18%\nin SWE312 Course \nContac with Your Advisor\nnourahksa@uhb.edu.sa',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          height: 1.3,
                          color: Color(0xFFC33232),
                          shadows: [Shadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
                        ),
                      ),
                    ),

                    // نص الحرمان الثابت
                    const Positioned(
                      width: 225, left: 111, top: 520,
                      child: Text(
                        'You will be denied if the percentage reaches 25%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF606060),
                          shadows: [Shadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
                        ),
                      ),
                    ),

                    // زر "Done"
                    Positioned(
                      width: 150, height: 50, left: 144, top: 645,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                              stops: [0.0, 0.4375, 0.9279, 1.0],
                            ),
                            border: Border.all(color: const Color(0xB58C8484)),
                            boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)],
                          ),
                          child: const Center(
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontFamily: 'IBM Plex Sans',
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Color(0xFF005D52),
                                shadows: [Shadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
                              ),
                            ),
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