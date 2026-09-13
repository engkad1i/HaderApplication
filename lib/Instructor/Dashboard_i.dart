import 'package:flutter/material.dart';
import 'package:hadeer/Instructor/SittingI.dart';
import 'package:hadeer/Screens/Auter_Wapper.dart';
import 'package:hadeer/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart'; // للتحكم في الجلسة وتسجيل الخروج
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // ضروري للتاريخ المحدث
import 'package:hadeer/Instructor/ProfileI.dart';
import 'package:hadeer/Instructor/GenerateQRScreen.dart';
import 'package:hadeer/Instructor/SREI.dart';
import 'package:hadeer/Instructor/manage_courses.dart';
import 'package:hadeer/Instructor/view_section.dart';
import 'package:hadeer/Instructor/create_course.dart';
import 'package:hadeer/Instructor/daily_attendance.dart';
class InsturctorDashboard extends StatelessWidget {
  const InsturctorDashboard({super.key});

  // دالة مساعدة لبناء النصوص بنفس النمط المستخدم في CSS
  Widget _buildCustomText(String text, double size, FontWeight weight, Color color,
      {bool isItalic = false, bool hasShadow = true}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: size,
        fontWeight: weight,
        color: color,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        shadows: hasShadow ? [
          const Shadow(offset: Offset(0, 4), blurRadius: 4, color: Color(0x40000000))
        ] : null,
      ),
    );
  }

  // ويدجت البطاقات (Cards) المتكررة في التصميم
  Widget _buildActionCard({
    required String title,
    required double top,
    required VoidCallback onTap,
    double left = 19,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 402,
          height: 65,
          decoration: BoxDecoration(

            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
              stops: [0.0, 0.43, 0.92, 1.0],
            ),
            borderRadius: BorderRadius.circular(40),
            border: const Border(top: BorderSide(color: Color(0x4A3C3C43), width: 2)),
            boxShadow: const [BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 38,
                top: 19,
                child: _buildCustomText(title, 20, FontWeight.w300, const Color(0xFF005D52), isItalic: true),
              ),
              Positioned(
                right: 15,
                top: 12,
                child: Image.asset('assets/3.png', width: 40), // Arrow icon
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على التاريخ الحالي وتنسيقه
    DateTime now = DateTime.now();
    String dayNumber = DateFormat('d').format(now);
    String dayName = DateFormat('EEEE').format(now);
    String monthYear = DateFormat('MMMM yyyy').format(now);
    String daySuffix = "th"; // يمكنك عمل دالة لاختيار st, nd, rd, th حسب الرقم

    return Scaffold(
      body: Container(
        width: 440,
        height: 956,
        decoration: const BoxDecoration(

          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
            stops: [0.0, 0.43, 0.92, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Hello Text
            Positioned(
              left: 26,
              top: 60,
              child: _buildCustomText("Hello !", 36, FontWeight.w400, const Color(0xFF005D52)),
            ),

            // Logo Image (64.png)
            Positioned(
              left: 190,
              top: 35,
              child: Image.asset('assets/64.png', width: 322, height: 181),
            ),

            // Green Rectangle with Curvature
            Positioned(
              top: 145,
              left: 0,
              right: 0,
              child: Container(
                width: 440,
                height: 811,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF29776E), Color(0xFF005D52), Color(0xFF005D52), Color(0xFF29776E)],
                    stops: [0.0, 0.05, 0.92, 1.0],
                  ),
                ),
              ),
            ),

            // Profile Button
            Positioned(
              left: 350,
              top: 180,
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileI())),
                child: Image.asset('assets/2.png', width: 60),
              ),
            ),

            // Dashboard Label
            Positioned(
              left: 42,
              top: 187,
              child: _buildCustomText("Your Dashboard", 20, FontWeight.w300, Colors.white),
            ),

            // Separator Line
            Positioned(
              top: 243,
              child: Image.asset('assets/5.png', width: 440),
            ),

            // Date Card
            Positioned(
              left: 19,
              top: 278,
              child: Container(
                width: 402,
                height: 118,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                  border: const Border(top: BorderSide(color: Color(0x4A3C3C43), width: 3)),
                ),
                child: Stack(
                  children: [
                    Positioned(left: 43, top: 19, child: _buildCustomText(dayNumber, 60, FontWeight.w600, const Color(0xFF005D52))),
                    Positioned(left: 115, top: 22, child: _buildCustomText(daySuffix, 20, FontWeight.w200, const Color(0xFF8AA5A1), hasShadow: false)),
                    Positioned(left: 151, top: 32, child: _buildCustomText(dayName, 20, FontWeight.w300, const Color(0xFF005D52))),
                    Positioned(left: 122, top: 54, child: _buildCustomText(monthYear, 15, FontWeight.w200, const Color(0xFF8AA5A1))),
                  ],
                ),
              ),
            ),

            // Class In Progress Section
            Positioned(
              left: 40,
              top: 416,
              child: _buildCustomText("Class In Progress", 13, FontWeight.w300, Colors.white, isItalic: true),
            ),

            // Course Card (The one with Generate button)
            Positioned(
              left: 19,
              top: 437,
              child: Container(
                width: 402,
                height: 65,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)]),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  children: [
                    Positioned(left: 40, top: 13, child: _buildCustomText("Lecture", 12, FontWeight.w300, Colors.black)),
                    Positioned(left: 43, top: 33, child: _buildCustomText("SWE31 : User Interface", 10, FontWeight.w300, const Color(0xFF005D52))),
                    // Generate Button
                    Positioned(
                      right: 15,
                      top: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GenerateQRScreen())),
                        child: Container(
                          width: 66,
                          height: 23,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xB58C8484)),
                          ),
                          alignment: Alignment.center,
                          child: _buildCustomText("Generate", 11, FontWeight.w500, const Color(0xFF005D52)),
                        ),
                      ),
                    )
                  ],

                ),
              ),

            ),
            Positioned(right: 20, top: 290, child: Image.asset('assets/1.png', width: 103, height: 96)),


            // Bottom Action Cards
            _buildActionCard(
              title: "View Daily Attendance",
              top: 521,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DailyAttendanceScreen()));
              },
            ),

            _buildActionCard(
              title: "Manage Courses",
              top: 615,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCoursesScreen()));
              },
            ),

            _buildActionCard(
              title: "View Sections",
              top: 702,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewSectionScreen()));
              },
            ),

            _buildActionCard(
              title: "Create Course",
              top: 796,
              left: 16,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCourseScreen()));
              },
            ),

            // Bottom Settings & Help Icons
            Positioned(
              right: 60,
              bottom: 19,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SittingI()),
                  );
                },
                child: Image.asset('assets/6.png', width: 40),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  // كود الانتقال لصفحة أخرى
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SystemReportsPageI()), // استبدل NextPage باسم صفحتك
                  );
                },
                child: Image.asset(
                  'assets/4.png',
                  width: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}