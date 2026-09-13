import 'package:flutter/material.dart';
import 'package:hadeer/Student/SER3S.dart';

class SystemErrorReportPageS2 extends StatelessWidget {
  const SystemErrorReportPageS2({super.key});

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
            // صورة الخلفية العلوية (65.png)
            Positioned(
              left: 219,
              top: 10,
              width: 277,
              height: 155,
              child: Opacity(
                opacity: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    image: const DecorationImage(
                      image: AssetImage('assets/65.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // زر الرجوع (Back Button)
            Positioned(
              left: 43,
              top: 59,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // العودة للصفحة السابقة
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF212121), size: 22),
                ),
              ),
            ),

            // البطاقة البيضاء الرئيسية (Rectangle 34)
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Column(
                    children: [
                      const SizedBox(height: 48),
                      // العنوان الكبير
                      const Text(
                        "System Error Report",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          color: Color(0xFF005D52),
                          shadows: [
                            Shadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),

                      // حقل عنوان التقرير (Rectangle 16)
                      _buildInputField(
                        hint: "Report Title",
                        height: 40,
                      ),

                      const SizedBox(height: 31),

                      // حقل وصف التقرير (Rectangle 35 - الكبير)
                      _buildInputField(
                        hint: "Description of Report",
                        height: 274,
                        maxLines: 10,
                      ),

                      const SizedBox(height: 75),

                      // زر Send (Rectangle 33)
                      GestureDetector(
                        onTap: () {
                          // هنا تضع الكود للانتقال لصفحة النجاح مثلاً
                           Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessSendReportPageS()));
                        },
                        child: Container(
                          width: 225,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xB58C8484)),
                            boxShadow: const [
                              BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 4)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Send",
                                style: TextStyle(
                                  fontFamily: 'IBM Plex Sans',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color: Color(0xFF005D52),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجت بناء الحقول
  Widget _buildInputField({required String hint, required double height, int maxLines = 1}) {
    return Container(
      width: 356,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFCFDFDD),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 4)),
        ],
      ),
      alignment: maxLines > 1 ? Alignment.topLeft : Alignment.centerLeft,
      padding: EdgeInsets.only(left: 25, right: 25, top: maxLines > 1 ? 20 : 0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            fontFamily: 'IBM Plex Sans',
            fontStyle: FontStyle.italic,
            fontSize: 12,
            color: Color(0xFF737373),
          ),
        ),
      ),
    );
  }
}