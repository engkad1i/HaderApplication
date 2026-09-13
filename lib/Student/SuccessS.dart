import 'package:flutter/material.dart';
import 'package:hadeer/Student/Dashboard_S.dart';

// واجهة صفحة النجاح المبنية بالكامل على قياسات وتصميم الـ CSS المرسل
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الأبعاد الثابتة للتصميم الأصلي (يمكن الاعتماد عليها للتطابق الكامل)
    const double designWidth = 440.0;
    const double designHeight = 956.0;

    // جلب أبعاد الشاشة الفعلية لحساب النسبي المئوي للأيقونة (Tick Square) إذا رغبتِ،
    // ولكن تم تحويلها هنا إلى أبعاد وـ Positioned دقيق لتتطابق مع الـ Figma.

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // /* Sucsuss_L */ خلفية الصفحة التدرجية بالكامل
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
            // /* 65 4 */ الصورة العلوية بالخلفية
            Positioned(
              width: 277,
              height: 155,
              left: 219,
              top: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),

                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    'assets/65.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // /* Subtract & Union */ زر السهم يرجع لصفحة Dashboard
            Positioned(
              width: 50,
              height: 50,
              left: 43,
              top: 59,
              child: GestureDetector(
                onTap: () {
                  // الانتقال لصفحة الـ Dashboard واستبدال الصفحة الحالية
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Dashboard_s(),
                    ),
                  );
                },
                child: Container(
                  child: Image.asset(
                    'assets/12.png', // اسم صورة السهم المطلوبة
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // /* Rectangle 34 */ الكارد الأبيض المنحني الرئيسي السفلي
            Positioned(
              width: 440,
              height: 811,
              left: 0,
              top: 151,
              child: Container(
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
                ),
                child: Stack(
                  children: [
                    // /* Scan Attendance */ العنوان الرئيسي داخل الكارد
                    Positioned(
                      width: 378,
                      height: 80,
                      left: 31,
                      top: 71, // تم ضبط التموضع نسبةً لبداية الـ Container (222 - 151)
                      child: const Text(
                        'Scan Attendance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF005D52),
                          shadows: [
                            Shadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // /* Iconly/Sharp/Light/Tick Square */ مساحة صورة الصح 17.png بناءً على النسب المئوية للـ CSS المرسل
                    Positioned(
                      left: 50, // مستنتج تقريبياً ومتوافق مع قياسات الـ Figma المكتوبة بالنسبة
                      top: 230,
                      width: designWidth * (1 - 0.1705 - 0.1182),
                      height: designHeight * (1 - 0.3755 - 0.2971),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // صورة الصح الأساسية المطلوبة (17.png) داخل الحدود والظلال
                          Container(
                            decoration: BoxDecoration(

                            ),
                            child: Image.asset(
                              'assets/17.png', // صورة الصح المستهدفة
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // /* THANK YOU ! */ نص الشكر والتقدير
                    Positioned(
                      width: 225,
                      height: 54,
                      left: 106,
                      top: 550, // تم ضبط التموضع نسبةً لبداية الـ Container (672 - 151)
                      child: const Text(
                        'THANK YOU !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF005D52),
                          shadows: [
                            Shadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // /* Your Attendance Has been Recorded */ نص تأكيد تسجيل الحضور السفلي المائل
                    Positioned(
                      top: 600,
                      left: designWidth * 0.0671,
                      right: designWidth * 0.1118,
                      bottom: 40, // ضبط متناسق مع أسفل البطاقة البيضاء بدلاً من الأرقام السالبة للـ CSS الخارج عن الإطار
                      child: const Text(
                        'Your Attendance Has been Recorded',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Color(0xFF005D52),
                          shadows: [
                            Shadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
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

