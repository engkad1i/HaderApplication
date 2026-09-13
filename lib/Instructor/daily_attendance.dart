import 'package:flutter/material.dart';
import 'daily_attendance2.dart';
import 'package:hadeer/Instructor/Dashboard_i.dart';

class DailyAttendanceScreen extends StatefulWidget {
  const DailyAttendanceScreen({super.key});

@override
  State<DailyAttendanceScreen> createState() => _DailyAttendanceScreenState();
}
class _DailyAttendanceScreenState extends State<DailyAttendanceScreen> {
String? selectedCourseId;
String? selectedSectionId;
String? selectedLectureId;

String? selectedCourseName;
String? selectedSectionNum;

  @override
  Widget build(BuildContext context) {

    const BoxDecoration figmaGradientDecoration = BoxDecoration(
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
    );
    return Scaffold(
      body: Stack(
        children: [
          // 1. الخلفية الخضراء المتدرجة
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

          // 2. الحاوية البيضاء المنحنية (القاعدة)
          Positioned(
            top: 151,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                // التعديل المضاف: التدرج اللوني للحاوية حسب CSS Rectangle 34
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
              ),

              // المحتوى داخل الحاوية البيضاء
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Daily Attendance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF005D52),
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 1. Dropdown للمواد (Course)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: _buildCustomDropdown(
                          "Select Course", 
                          [
                          DropdownMenuItem(value: "1", child: Text("SWE312: User Interface")),
                          DropdownMenuItem(value: "2", child: Text("SWE321: Software Design")),
                          ],
                          figmaGradientDecoration,
                          selectedCourseId, 
                         (value) => setState(() => selectedCourseId = value),
                          ),
                          ),
                      
                    
                  

                  // 2. Dropdown للشُعب (Class)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: _buildCustomDropdown(
                          "Select Section", 
                          [
                          DropdownMenuItem(value: "101", child: Text("Section 101")),
                          DropdownMenuItem(value: "102", child: Text("Section 102")),
                          ],
                          figmaGradientDecoration,
                          selectedSectionId, 
                         (value) => setState(() => selectedSectionId = value),
                          ),
                        ),

                  

                  // 3. Dropdown للتاريخ (Lecture)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: _buildCustomDropdown(
                      "Select Date",
                      [
                        const DropdownMenuItem(value: "d1", child: Text("8/12/2025", style: TextStyle(fontFamily: 'IBM Plex Sans', fontStyle: FontStyle.italic))),
                        const DropdownMenuItem(value: "d2", child: Text("9/12/2025", style: TextStyle(fontFamily: 'IBM Plex Sans', fontStyle: FontStyle.italic))),
                      ],
                      figmaGradientDecoration,
                      selectedLectureId,
                      (value) {
                        setState(() {
                          selectedLectureId = value;
                        });
                      },
                    ),
                  ),

                  const Spacer(),

                  // زر البحث (Search)
                  Container(
                    width: 225, // حسب العرض في Figma
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: figmaGradientDecoration.gradient,
                      border: Border.all(color: const Color(0xB58C8484), width: 1), // الـ Border الرمادي
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                      if (selectedCourseId != null && selectedSectionId != null && selectedLectureId != null) {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => DailyAttendanceScreen2(
                      courseId: selectedCourseId!,
                      sectionId: selectedSectionId!,
                      lectureId: selectedLectureId!,
                     ),
                   ),
                 );
                } else {
                   // تنبيه للمستخدم في حال لم يختر أحد الحقول
                   ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                   content: Text("Please select Course, Section, and Date"),
                   backgroundColor: Colors.redAccent,
                   ),
                 );
               }
              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // لجعل التدرج يظهر
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        "Search",
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontStyle: FontStyle.italic,
                          fontSize: 24, // حسب الـ CSS
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF005D52),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),

          // 3. الشعار
          Positioned(
            top: -30,
            right: -50
            ,
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

  // دالة مخصصة لبناء شكل الـ Dropdown الأنيق
  Widget _buildCustomDropdown(String hint, List<DropdownMenuItem<String>> items, BoxDecoration decoration, String? currentValue, Function(String?) onChangedAction) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: decoration.gradient,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontFamily: 'IBM Plex Sans',fontStyle: FontStyle.italic,fontSize: 20, color: Color(0xB58C8484)),
          ),
          items: items,
          onChanged: onChangedAction,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF005D52)),
        ),
      ),
    );
  }
}
extension ShadowExtension on Shadow {
  BoxShadow toBoxShadow() => BoxShadow(
    color: color,
    offset: offset,
    blurRadius: blurRadius,
    spreadRadius: 0.0,
  );
}