import 'package:flutter/material.dart';
import 'package:hadeer/Admin/Dashboard_A.dart';
import 'package:hadeer/Screens/splash_screen.dart';

class SittingA extends StatefulWidget {
  const SittingA({super.key});

  @override
  State<SittingA> createState() => _SittingState();
}

class _SittingState extends State<SittingA> {
  // حالة اللغة المختارة: 'English' أو 'Arabic'
  String selectedLanguage = 'English';
  // التحكم في ظهور رسالة التنبيه والخطأ
  bool showArabicWarning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 440,
        height: 956,
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
            // الشعار العلوي (65.png)
            Positioned(
              left: 219,
              top: 10,
              child: Container(
                width: 277,
                height: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: const DecorationImage(
                    image: AssetImage('assets/65.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // زر الرجوع (Arrow 8.png)
            Positioned(
              left: 43,
              top: 65,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // العودة لـ AdminDashboard
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/12.png'),
                ),
              ),
            ),

            // الحاوية الرئيسية (Rectangle 34)
            Positioned(
              top: 151,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                    stops: [0.0, 0.4375, 0.9279, 1.0],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Stack(
                  children: [
                    // عنوان الصفحة Sitting
                    const Positioned(
                      left: 30,
                      top: 48,
                      child: SizedBox(
                        width: 378,
                        child: Text(
                          "Sitting",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans',
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF005D52),
                          ),
                        ),
                      ),
                    ),
                    // نص Choose Language
                    const Positioned(
                      left: 32,
                      top: 173, // (324 - 151)
                      child: Text(
                        "Choose Language",
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF005D52),
                        ),
                      ),
                    ),

                    // خيار اللغة العربية
                    _buildLanguageRow(
                      label: "Arabic",
                      topPos: 218, // (369 - 151)
                      isSelected: selectedLanguage == 'Arabic',
                      isError: showArabicWarning,
                      onTap: () {
                        setState(() {
                          selectedLanguage = 'Arabic';
                          showArabicWarning = true;
                        });
                      },
                    ),

                    // خيار اللغة الإنجليزية
                    _buildLanguageRow(
                      label: "English",
                      topPos: 264, // (415 - 151)
                      isSelected: selectedLanguage == 'English',
                      isError: false,
                      onTap: () {
                        setState(() {
                          selectedLanguage = 'English';
                          showArabicWarning = false;
                        });
                      },
                    ),

                    // --- رسالة التنبيه والشعار (تظهر فقط عند اختيار عربي) ---
                    if (showArabicWarning) ...[
                      Positioned(
                        left: 198,
                        top: 488, // (639 - 151)
                        child: Image.asset('assets/10.png', width: 40, height: 40),
                      ),
                      const Positioned(
                        left: 102,
                        top: 550, // (653 - 151)
                        child: SizedBox(
                          width: 225,
                          child: Text(
                            "The Arabic Language Will Be Soon in Hader Application",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans',
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFCC0000),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],

                    // زر Done
                    Positioned(
                      left: 107,
                      top: 645, // (796 - 151)
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context), // العودة لـ AdminDashboard
                        child: Container(
                          width: 225,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xB58C8484)),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
                          ),
                          child: const Text(
                            "Done",
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans',
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFF005D52),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // نص حقوق التطوير
                    const Positioned(
                      left: 80,
                      top: 710, // (830 - 151)
                      child: Text(
                        "This Application Was Developed By Saudi Team",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF606060),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                    // زر Logout (11.png)
                    Positioned(
                      left: 382,
                      top: 725, // (868 - 151)
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const SplashScreen()),
                                (route) => false,
                          );
                        },
                        child: Image.asset('assets/11.png', width: 30, height: 30),
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

  // دالة بناء صف اختيار اللغة (المستطيل والدائرة)
  Widget _buildLanguageRow({
    required String label,
    required double topPos,
    required bool isSelected,
    required bool isError,
    required VoidCallback onTap,
  }) {
    return Stack(
      children: [
        // المستطيل (Rectangle 16/35)
        Positioned(
          left: 17,
          top: topPos,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 255,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFCFDFDD),
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
              ),
              padding: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'IBM Plex Sans',
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  color: Color(0xFF737373),
                ),
              ),
            ),
          ),
        ),
        // الدائرة (Ellipse 16/17)
        Positioned(
          left: 288,
          top: topPos,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // إذا تم اختيار العربي تظهر حدود حمراء، وإذا تم اختيار الإنجليزي تمتلئ بالأخضر
                color: (isSelected && label == 'English') ? const Color(0xFF005D52) : Colors.transparent,
                border: Border.all(
                  color: isError ? const Color(0xFFCC0000) : const Color(0xFF005D52),
                  width: 1,
                ),
                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 40, offset: Offset(0, 0))],
              ),
              child: (isSelected && label == 'English')
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

