import 'package:flutter/material.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    // --- الألوان الموحدة للهوية (مطابقة لصفحة البحث) ---
    const Color primaryGreen = Color(0xFF005D52);
    const Color lightGreen = Color(0xFF29776E);
    const Color surfaceGray = Color(0xFFD9D9D9);

    return Scaffold(
      resizeToAvoidBottomInset: false, 
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // --- الخلفية الخضراء الموحدة ---
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightGreen, primaryGreen],
          ),
        ),
        child: Stack(
          children: [
            // الشعار/الصورة العلوية
            Positioned(
              right: -50, top: 10,
              child: Image.asset('assets/65.png', width: 277, height: 155, fit: BoxFit.contain, 
                errorBuilder: (c, e, s) => const SizedBox()),
            ),
            
            // زر الرجوع
            Positioned(
              left: 43, top: 59,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38, height: 38,
                  decoration: const BoxDecoration(
                    color: Colors.white, 
                    shape: BoxShape.circle, 
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]
                  ),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF212121), size: 20),
                ),
              ),
            ),

            // الحاوية الأساسية
            Positioned(
              top: 151, left: 0, right: 0, bottom: 0,
              child: Container(
                // --- الخلفية الرمادية/البيضاء الموحدة (مطابقة لصفحة البحث) ---
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [surfaceGray, Colors.white, Colors.white, surfaceGray],
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              const SizedBox(height: 35),
                              
                              // العنوان بخط IBM Plex Sans
                              const Text(
                                "Upload Document", 
                                style: TextStyle(
                                  fontFamily: 'IBM Plex Sans', 
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 40, 
                                  color: primaryGreen
                                )
                              ),

                              const SizedBox(height: 60),
                              
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Verification Doc", 
                                    style: TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.bold, fontSize: 16, color: primaryGreen)),
                                ),
                              ),
                              
                              const SizedBox(height: 15),
                              // منطقة الرفع (Box) باللون الأبيض الصافي والظل الخفيف
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                child: Container(
                                  width: double.infinity,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: const Color(0xFFDBDBDB), width: 1.2), 
                                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: const BoxDecoration(color: Color(0xFFCFDFDD), shape: BoxShape.circle),
                                        child: const Icon(Icons.cloud_upload_outlined, color: primaryGreen, size: 35),
                                      ),
                                      const SizedBox(height: 15),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Drop your files here or ", style: TextStyle(fontFamily: 'Tajawal', fontSize: 14, color: Colors.black87)),
                                          Text("Browse", style: TextStyle(fontFamily: 'Tajawal', fontSize: 14, fontWeight: FontWeight.bold, color: primaryGreen)),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Text("SVG, PNG, JPG (max. 800x400px)", style: TextStyle(fontFamily: 'Tajawal', fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ),

                              const Spacer(),

                              // زر Done الموحد بنفس تدرج زر Search
                              Padding(
                                padding: const EdgeInsets.only(top: 30, bottom: 40),
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    width: 160,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [surfaceGray, Colors.white, Colors.white, surfaceGray],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Done', 
                                        style: TextStyle(
                                          fontFamily: 'Tajawal', 
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 24, 
                                          color: primaryGreen
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}