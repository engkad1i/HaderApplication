import 'package:flutter/material.dart';

class SuccessDownloadedScreen extends StatelessWidget {
  const SuccessDownloadedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. الخلفية المتدرجة (Gradient Background)
          Container(
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
          ),

          // 2. الحاوية البيضاء المنحنية (Rectangle 34)
          Positioned(
            top: 151,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFD9D9D9),
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                    Color(0xFFD9D9D9),
                  ],
                  stops: [0.0, 0.4375, 0.9279, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // عنوان Daily Attendance
                  const Text(
                    "Daily Attendance",
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF005D52),
                    ),
                  ),
                  
                  const Spacer(flex: 1),

                  // أيقونة النجاح (الصح الأخضر)
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Color(0xFF05CB29),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
                      ],
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 120),
                  ),

                  const SizedBox(height: 40),

                  // نصوص الشكر والنجاح
                  const Text(
                    "THANK YOU",
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF005D52),
                    ),
                  ),
                  const Text(
                    "The Report was Downloaded Successfully",
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans',
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF005D52),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // زر Done
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0xB58C8484)),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF005D52),
                              fontWeight: FontWeight.w500,
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

          // الشعار (Logo)
          Positioned(
            top: -30,
            right: -50,
            child: Image.asset('assets/65.png', width: 260, height: 260),
          ),

          // أيقونة العودة
          Positioned(
            top: 60,
            left: 25,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                
                child: Image.asset(
               'assets/12.png',
               width: 50,  // عرض الصورة
               height: 50, // طول الصورة
               fit: BoxFit.contain,
               ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}