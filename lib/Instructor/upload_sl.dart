import 'package:flutter/material.dart';

class UploadVerificationScreen extends StatelessWidget {
  const UploadVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // التدرج اللوني للخلفية (Rectangle 34) حسب الـ CSS
    const BoxDecoration figmaContainerDecoration = BoxDecoration(
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
    );

    return Scaffold(
      body: Stack(
        children: [
          // 1. الخلفية الخضراء المتدرجة (Upload_SL background)
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

          // 2. الحاوية البيضاء الرئيسية (Rectangle 34)
          Positioned(
            top: 151,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: figmaContainerDecoration,
              child: Column(
                children: [
                  const SizedBox(height: 143), // المسافة للوصول لمنطقة الرفع (294px من التوب الكلي)

                  // منطقة رفع الملفات (File Uploader)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // النص العلوي (Upload Verification Doc)
                        const Text(
                          "Upload Verification Doc",
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Color(0xFF11181C),
                          ),
                        ),
                        const SizedBox(height: 6),
                        
                        // صندوق الرفع المقطع (Frame 47754)
                        Container(
                          width: double.infinity,
                          height: 152,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFDBDBDB),
                              width: 1,
                              style: BorderStyle.solid, // ملاحظة: فلاتر لا يدعم Dash border مباشرة بدون مكتبة، لذا استخدمت Solid حالياً
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // أيقونة الرفع (Frame 47751)
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFCFDFDD),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.file_upload_outlined,
                                  color: Color(0xFF005D52),
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // نصوص منطقة الرفع
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Drop your files here or ",
                                    style: TextStyle(
                                      fontFamily: 'Mulish',
                                      fontSize: 14,
                                      color: Color(0xFF11181C),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // هنا تضعين كود فتح الاستوديو أو الملفات
                                    },
                                    child: const Text(
                                      "Click to upload",
                                      style: TextStyle(
                                        fontFamily: 'Mulish',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color(0xFF005D52),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "SVG, PNG, JPG or GIF (max. 800x400px)",
                                style: TextStyle(
                                  fontFamily: 'Mulish',
                                  fontSize: 12,
                                  color: Color(0xFF64696B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // زر Done (Rectangle 33)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 225,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: figmaContainerDecoration.gradient,
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
                              fontFamily: 'IBM Plex Sans',
                              fontStyle: FontStyle.italic,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF005D52),
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

          // 3. الشعار (نفس موقع وأبعاد الـ CSS)
          Positioned(
            top: -30,
            right : -30,
            child: Image.asset(
              'assets/65.png',
              width: 260,
              height: 260,
              fit: BoxFit.contain,
            ),
          ),

          // 4. أيقونة العودة
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