import 'package:flutter/material.dart';
import 'package:hadeer/Instructor/Dashboard_i.dart';

class SuccessSendReportPageI extends StatelessWidget {
  const SuccessSendReportPageI({super.key});

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
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 4)),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF212121), size: 22),
                ),
              ),
            ),

            // الحاوية البيضاء الرئيسية
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
                  alignment: Alignment.topCenter,
                  children: [
                    // عنوان الصفحة
                    const Positioned(
                      top: 48,
                      child: Text(
                        "System Error Report",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                          color: Color(0xFF005D52),
                          shadows: [Shadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
                        ),
                      ),
                    ),

                    // أيقونة النجاح (Success -- 17.png)
                    Positioned(
                      top: 180,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/17.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    // نصوص الشكر (Thank You & Message)
                    Positioned(
                      top: 488, // تقريباً حسب إحداثيات CSS
                      child: Column(
                        children: const [
                          Text(
                            "THANK YOU",
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              letterSpacing: 1.2,
                              color: Color(0xFF005D52),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Your Report Was Sent Successfully",
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Color(0xFF005D52),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // زر Done (Rectangle 33)
                    Positioned(
                      bottom: 60, // تم ضبطه ليكون في الأسفل
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InsturctorDashboard()));

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
                                "Done",
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