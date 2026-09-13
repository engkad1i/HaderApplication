import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final bool isSuccess;

  const ResultScreen({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
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
            // الشعار العلوي الأبيض (65.png)
            Positioned(
              width: 277, height: 155, left: 219, top: 10,
              child: Image.asset('assets/65.png', fit: BoxFit.contain),
            ),

            // زر العودة (يرجع للخلف إلى صفحة الـ Scan)
            Positioned(
              width: 38,
              height: 38,
              left: 43,
              top: 59,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  'assets/12.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // الكارت الرئيسي السفلي (Rectangle 34)
            Positioned(
              top: 151, left: 0, right: 0, bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
                ),
                child: Stack(
                  children: [
                    // العنوان الثابت للتصميم
                    const Positioned(
                      top: 71, left: 0, right: 0,
                      child: Text(
                        'Scan Attendance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF005D52),
                          fontFamily: 'IBM Plex Sans',
                        ),
                      ),
                    ),

                    // عرض البيانات الديناميكية بناءً على حالة النجاح/الفشل
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
                          // عرض أيقونة النتيجة المناسبة وحجم الـ Stroke المذكور
                          Image.asset(
                            isSuccess ? 'assets/17.png' : 'assets/18.png',
                            width: 160,
                            height: 160,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 40),

                          // نص العنوان (THANK YOU! أو SORRY!)
                          Text(
                            isSuccess ? 'THANK YOU !' : 'SORRY !',
                            style: const TextStyle(
                              fontFamily: 'IBM Plex Sans',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color(0xFF005D52),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // نص الوصف الفرعي من الكود الخاص بك
                          Text(
                            isSuccess
                                ? 'Your Attendance Has Been Recorded'
                                : 'You are Not in The Class',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'IBM Plex Sans',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: Color(0xFF005D52),
                            ),
                          ),
                        ],
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