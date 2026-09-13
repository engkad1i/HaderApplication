import 'package:flutter/material.dart';
import 'package:hadeer/Student/SRE2S.dart';
import 'package:hadeer/Student/Dashboard_s.dart';
class SystemReportsPageS extends StatelessWidget {
  const SystemReportsPageS ({super.key});

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

            // زر الرجوع (Back Button)
            Positioned(
              left: 43,
              top: 59,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // يرجع للصفحة السابقة
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF212121), size: 20),
                ),
              ),
            ),

            // الحاوية البيضاء الرئيسية (Rectangle 34)
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
                    stops: [0.0, 0.43, 0.92, 1.0],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 48),
                      // عنوان الصفحة
                      const Text(
                        "System Error Report",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          color: Color(0xFF005D52),
                          shadows: [
                            Shadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 4),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),

                      // الحقول (Text Fields)
                      _buildCustomField("Full Name", 0),
                      const SizedBox(height: 31),
                      _buildCustomField("ID", 0),
                      const SizedBox(height: 31),
                      _buildCustomField("Role", 0),
                      const SizedBox(height: 31),
                      _buildCustomField("Email", 0),

                      const SizedBox(height: 150),

                      // زر Send (Rectangle 33)
                      GestureDetector(
                        onTap: () {
                          // انقل لصفحة ثانية هنا
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SystemErrorReportPageS2()));
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
                              BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Next",
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

  // ودجت بناء الحقول المتكررة
  Widget _buildCustomField(String hint, double top) {
    return Container(
      width: 356,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        color: const Color(0xFFCFDFDD),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4)),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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