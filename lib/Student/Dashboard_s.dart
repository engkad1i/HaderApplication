import 'package:hadeer/Student/ProfileS.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hadeer/Screens/Auter_Wapper.dart';
import 'package:hadeer/Screens/login.dart';
import 'package:hadeer/Student/ProfileS.dart';
import 'package:hadeer/Student/SRES.dart';
import 'package:hadeer/Student/SittingS.dart';
import 'package:hadeer/Student/Attendance_Record_Screen.dart';
import 'package:hadeer/Student/Alert_Detail_Screen.dart';
import 'package:hadeer/Student/Scan_attendance.dart';
class Dashboard_s extends StatelessWidget {
  // أضيفي هذا السطر بدقة
  const Dashboard_s({super.key});
  @override
  Widget build(BuildContext context) {
    // منطق التاريخ التلقائي
    DateTime now = DateTime.now();
    String dayNum = DateFormat('d').format(now);
    String dayName = DateFormat('EEEE').format(now);
    String monthYear = DateFormat('MMMM yyyy').format(now);
    String daySuffix = _getSuffix(now.day);

    return Scaffold(
      body: Container(
        width: 440,
        height: 956,
        // تدرج الخلفية الرئيسي (الصفحة الرئيسية)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
            stops: [0.0, 0.20, 0.90, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // صورة 64 (الشعار العلوي)
            Positioned(
              top: 35,
              left: (MediaQuery.of(context).size.width / 2) - (322 / 2) + 143,
              child: Image.asset('assets/64.png', width: 322, height: 181),
            ),

            // Hello !
            Positioned(
              left: 35,
              top: 80,
              child: _buildText("Hello !", 36, FontWeight.w400, const Color(0xFF005D52), hasShadow: true),
            ),

            // الحاوية الخضراء الكبيرة (Rectangle 27) مع الانحناءات المطلوبة
            Positioned(
              top: 145,
              right : 0,
              left: 0,
              child: Container(
                width: 440,
                height: 811,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF29776E), Color(0xFF005D52), Color(0xFF005D52), Color(0xFF29776E)],
                    stops: [0.0, 0.0529, 0.9231, 1.0],
                  ),
                ),
              ),
            ),

            // الخط الفاصل (line1&2 -- 5.png)
            Positioned(
              top: 243,
              left: 0,
              child: Image.asset('assets/5.png', width: 440),
            ),

            // Your Dashboard Text
            Positioned(
              left: 42,
              top: 187,
              child: _buildText("Your Dashboard", 20, FontWeight.w300, Colors.white, hasShadow: true, shadowOpacity: 0.4),
            ),

            // Profile Button (2.png)
            Positioned(
              left: 350,
              top: 180,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ProfileS()),
                  );
                },
                child: Image.asset(
                  'assets/2.png',
                  width: 60,
                  height: 60,
                ),
              ),
            ),

            // --- بطاقة التاريخ (تحديث تلقائي) ---
            Positioned(
              left: 19,
              top: 278,
              child: _buildCard(118, children: [
                Positioned(left: 43, top: 19, child: _buildText(dayNum, 60, FontWeight.w600, const Color(0xFF005D52), hasShadow: true)),
                Positioned(left: 115, top: 22, child: _buildText(daySuffix, 20, FontWeight.w200, const Color(0xFF8AA5A1), hasShadow: true)),
                Positioned(left: 151, top: 32, child: _buildText(dayName, 20, FontWeight.w300, const Color(0xFF005D52), hasShadow: true)),
                Positioned(left: 122, top: 54, child: _buildText(monthYear, 15, FontWeight.w200, const Color(0xFF8AA5A1), hasShadow: true)),
                // Date Icon (1.png)
                Positioned(right: 20, top: 11, child: Image.asset('assets/1.png', width: 103, height: 96)),
              ]),
            ),

            // Upcoming Lecture Section
            _buildSectionLabel("Upcoming Lecture", 416),
            Positioned(
              left: 19,
              top: 437,
              child: _buildCard(65, children: [
                Positioned(left: 21, top: 11, child: _buildText("Lecture", 13, FontWeight.w300, const Color(0xFF212121), italic: true)),
                Positioned(left: 155, top: 11, child: _buildText("Date", 13, FontWeight.w300, const Color(0xFF212121), italic: true)),
                Positioned(left: 244, top: 11, child: _buildText("Time", 13, FontWeight.w300, const Color(0xFF212121), italic: true)),
                Positioned(left: 21, top: 37, child: _buildText("SWE31 : User Interface", 10, FontWeight.w300, const Color(0xFF005D52), italic: true)),
                Positioned(
                  left: 155,
                  top: 37,
                  child: _buildText(
                    DateFormat('d MMMM yyyy').format(DateTime.now()), // استدعاء تاريخ اليوم وتنسيقه مباشرة
                    10,
                    FontWeight.w300,
                    const Color(0xFF005D52),
                    italic: true,
                  ),
                ),                Positioned(left: 244, top: 34, child: _buildText("10:00 AM ", 10, FontWeight.w300, const Color(0xFF005D52), italic: true)),
                // Scan Button (Rectangle 33)
                Positioned(
                  left: 315, top: 20,
                    child: GestureDetector(
                      onTap: () {
                        // الانتقال إلى صفحة ScanAttendanceScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScanAttendanceScreen()),
                        );
                      },
                  child: Container(
                    width: 66, height: 23,
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
                        stops: [0.1, 0.3, 0.5, 3.0],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xB58C8484)),
                    ),
                    alignment: Alignment.center,
                    child: _buildText("Scan", 13, FontWeight.w500, const Color(0xFF005D52), italic: true),
                  ),
                )
              )
            ]),

            ),

    // My Courses Section
            _buildSectionLabel("My Courses", 528),
            Positioned(
              left: 19,
              top: 551,
              child: _buildCard(118, children: [
                Positioned(left: 29, top: 10, child: _buildText("Course Name", 13, FontWeight.w300, const Color(0xFF212121), italic: true)),
                Positioned(left: 223, top: 10, child: _buildText("Absence Percentage", 13, FontWeight.w300, const Color(0xFF212121), italic: true)),
                _buildCourseRow("SWE316 : User Interface", "25%", 46),
                _buildCourseRow("CYP201 : Cybersecurity", "25%", 75),
              ]),
            ),

            // Attendance Records (Arrow 3.png)
            Positioned(
              left: 19,
              top: 702,
              child: _buildCard(65, children: [
                Positioned(
                    left: 38,
                    top: 20,
                    child: _buildText("Attendance Records", 20, FontWeight.w300, const Color(0xFF005D52), italic: true)
                ),
                Positioned(
                  right: 15,
                  top: 12,
                  child: GestureDetector(
                    onTap: () {
                      // الكود المسؤول عن الانتقال للصفحة الجديدة
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AttendanceRecordScreen()),
                      );
                    },
                    child: Image.asset('assets/3.png', width: 40),
                  ),
                ),
              ]),
            ),
            // Alerts Section
            _buildSectionLabel("Alerts", 784),
            Positioned(
              left: 19,
              top: 805,
              child: _buildCard(65, children: [
                Positioned(left: 15, top: 10, child: Image.asset('assets/7.png', width: 40 )), // Alert Icon
                Positioned(left: 73, top: 12, child: _buildAlertRow()),

                // تعديل هنا: إضافة GestureDetector للسهم
                Positioned(
                  right: 15,
                  top: 12,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AlertDetailScreen()),
                      );
                    },
                    child: Image.asset('assets/3.png', width: 40), // Arrow Icon
                  ),
                ),
              ]),
            ),

            // Bottom Buttons (Sitting 6.png & Help 4.png)
            Positioned(
              right: 70,
              bottom: 19,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SittingS()),
                  );
                },
                child: Image.asset('assets/6.png', width: 40),
              ),
            ),
            Positioned(
              right: 30,
              bottom: 19,
              child: GestureDetector(
                onTap: () {
                  // كود الانتقال لصفحة أخرى
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SystemReportsPageS()), // استبدل NextPage باسم صفحتك
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


  // دالة بناء البطاقة بالتدرج والظل المطلوب
  Widget _buildCard(double height, {required List<Widget> children}) {
    return Container(
      width: 402,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
          stops: [1.0, 0.5, 0.1, 8.0],
        ),
        boxShadow: const [BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 4))],
        border: const Border(top: BorderSide(color: Color(0x4A3C3C43), width: 3)),
      ),
      child: Stack(children: children),
    );
  }

  // دالة النصوص الموحدة
  Widget _buildText(String text, double size, FontWeight weight, Color color, {bool hasShadow = false, double shadowOpacity = 0.25, bool italic = false}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: size,
        fontWeight: weight,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        color: color,
        shadows: hasShadow ? [Shadow(color: Colors.black.withOpacity(shadowOpacity), offset: const Offset(0, 4), blurRadius: 4)] : null,
      ),
    );
  }

  Widget _buildSectionLabel(String text, double top) {
    return Positioned(
      left: 40, top: top,
      child: _buildText(text, 13, FontWeight.w300, Colors.white, italic: true),
    );
  }

  Widget _buildCourseRow(String name, String percentage, double top) {
    return Positioned(
      left: 29, top: top,
      child: Row(
        children: [
          SizedBox(width: 200, child: _buildText(name, 10, FontWeight.w300, const Color(0xFF005D52), italic: true)),
          _buildText(percentage, 10, FontWeight.w300, const Color(0xFF005D52), italic: true),
        ],
      ),
    );
  }

  Widget _buildAlertRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          SizedBox(width:100 ,child: _buildText("Alert Title   ", 10, FontWeight.w300, const Color(0xFF005D52), italic: true )),
          SizedBox(width: 110,child: _buildText("Course Name   ", 10, FontWeight.w300, const Color(0xFF005D52), italic: true)),
          SizedBox(width: 140,child: _buildText("Warning %", 10, FontWeight.w300, const Color(0xFF005D52), italic: true)),
        ]),
        Row(children: [
          SizedBox(width:100 ,child: _buildText("First Warning Notice   ", 8, FontWeight.w300, Colors.red, italic: true)),
          SizedBox(width: 110,child: _buildText("SWE312 : User Interface   ", 8, FontWeight.w300, Colors.red, italic: true)),
          SizedBox(width: 140,child: _buildText("18%", 8, FontWeight.w300, Colors.red, italic: true)),
        ]),
      ],
    );
  }

  String _getSuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }
}

