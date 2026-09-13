import 'package:flutter/material.dart';
import 'package:hadeer/Screens/Auter_Wapper.dart';
import 'package:hadeer/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart'; // للتحكم في الجلسة وتسجيل الخروج
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hadeer/Admin/SittingA.dart';
import 'package:intl/intl.dart';
import 'package:hadeer/Admin/Manage_Instructor.dart';
import 'package:hadeer/Admin/Manage_Student.dart';
import 'package:hadeer/Admin/Manage_SystemER.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // جلب بيانات التاريخ الحالية
    DateTime now = DateTime.now();
    String dayNumber = DateFormat('d').format(now);
    String dayName = DateFormat('EEEE').format(now);
    String monthYear = DateFormat('MMMM yyyy').format(now);

    // دالة لتحديد اللاحقة (st, nd, rd, th)
    String getDaySuffix(int day) {
      if (day >= 11 && day <= 13) return 'th';
      switch (day % 10) {
        case 1: return 'st';
        case 2: return 'nd';
        case 3: return 'rd';
        default: return 'th';
      }
    }

    return Scaffold(
      body: Container(
        width: 440, // بناءً على الـ CSS
        height: 956,
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
        ),
        child: Stack(
          children: [
            // Hello ! Text
            const Positioned(
              left: 26,
              top: 60,
              child: Text(
                "Hello !",
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans',
                  fontSize: 36,
                  color: Color(0xFF005D52),
                  fontWeight: FontWeight.w400,
                  shadows: [
                    Shadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)
                  ],
                ),
              ),
            ),

            // Logo (64.png)
            Positioned(
              top: 35,
              left: (MediaQuery.of(context).size.width / 2) - (322 / 2) + 143,
              child: Image.asset('assets/64.png', width: 322, height: 181),
            ),


            // Rectangle 27 - الخلفية الخضراء
            Positioned(
              top: 145,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),

                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF29776E),
                      Color(0xFF005D52),
                      Color(0xFF005D52),
                      Color(0xFF29776E),
                    ],
                    stops: [0.0, 0.0529, 0.9231, 1.0],
                  ),
                ),
              ),
            ),

            // Your Dashboard Text
            const Positioned(
              left: 42,
              top: 187,
              child: Text(
                "Your Dashboard",
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black45, offset: Offset(0, 4), blurRadius: 4)
                  ],
                ),
              ),
            ),

            // Line 5.png (الخط الفاصل)
            Positioned(
              top: 243,
              left: 0,
              right: 0,
              child: Image.asset('assets/5.png', fit: BoxFit.fitWidth),
            ),

            // Rectangle 28 - بطاقة التاريخ
            Positioned(
              left: 19,
              top: 278,
              child: _buildMainCard(
                height: 118,
                child: Stack(
                  children: [
                    // رقم اليوم (10)
                    Positioned(
                      left: 43,
                      top: 19,
                      child: Text(
                        dayNumber,
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF005D52),
                        ),
                      ),
                    ),
                    // اللاحقة (th)
                    Positioned(
                      left: 115,
                      top: 22,
                      child: Text(
                        getDaySuffix(now.day),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: Color(0xFF8AA5A1),
                        ),
                      ),
                    ),
                    // اليوم (Wednesday)
                    Positioned(
                      left: 151,
                      top: 32,
                      child: Text(
                        dayName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF005D52),
                        ),
                      ),
                    ),
                    // الشهر والسنة
                    Positioned(
                      left: 122,
                      top: 54,
                      child: Text(
                        monthYear,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w200,
                          color: Color(0xFF8AA5A1),
                        ),
                      ),
                    ),
                    // أيقونة التقويم (1.png)
                    Positioned(
                      right: 20,
                      top: 11,
                      child: Image.asset('assets/1.png', width: 103),
                    ),
                  ],
                ),
              ),
            ),

            // أزرار لوحة التحكم
            _buildActionButton(context, "Manage Instructor", 458, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageInstructorPage()));
            }),

            _buildActionButton(context, "Manage Student", 585, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageStudentSearch()));
            }),

            _buildActionButton(context, "Manage System Error Reports", 718, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SystemReportsPage()));
            }),

            // زر الإعدادات (6.png) في الأسفل
            Positioned(
              right: 25,
              bottom: 40,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SittingA()),
                  );
                },
                child: Image.asset('assets/6.png', width: 35, height: 35),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجت بناء الكروت الأساسية (التصميم المتكرر)
  Widget _buildMainCard({required double height, required Widget child}) {
    return Container(
      width: 402,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
        borderRadius: BorderRadius.circular(40),
        border: const Border(
          top: BorderSide(color: Color.fromRGBO(60, 60, 67, 0.29), width: 3),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)
        ],
      ),
      child: child,
    );
  }

// ودجت بناء الأزرار الكبيرة (المعدلة لتدعم الانتقال)
  Widget _buildActionButton(BuildContext context, String title, double topPosition, VoidCallback onTap) {
    return Positioned(
      left: 19,
      top: topPosition,
      child: GestureDetector(
        onTap: onTap, // هنا نقوم بتفعيل خاصية الضغط
        child: _buildMainCard(
          height: 65,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans',
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF005D52),
                    ),
                  ),
                ),
                Image.asset('assets/3.png', width: 40, height: 40), // السهم
              ],
            ),
          ),
        ),
      ),
    );
  }
}