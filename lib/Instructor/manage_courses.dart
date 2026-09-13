import 'package:flutter/material.dart';
import 'manage_courses2.dart'; // استيراد الملف الثاني

class ManageCoursesScreen extends StatefulWidget {
  const ManageCoursesScreen({super.key});

  @override
  State<ManageCoursesScreen> createState() => _ManageCoursesScreenState();
}

class _ManageCoursesScreenState extends State<ManageCoursesScreen> {
  String? selectedCourse;
  final List<String> courses = ["SWE312", "CS01"]; // المثالين

  @override
  Widget build(BuildContext context) {
    // التدرج اللوني المشترك المستخدم في التوقيع البصري الخاص بك
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
          // 1. الخلفية الخضراء المتدرجة (نفس الدرجات والـ stops)
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

          // 2. الحاوية البيضاء المنحنية المتدرجة
          Positioned(
            top: 151,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: figmaGradientDecoration.gradient,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Manage Courses",
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

                  const SizedBox(height: 50),
                  
                  // 3. Dropdown الاختيار (تم مطابقة التصميم والظلال)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: _buildCustomDropdown(
                      "Select Course", 
                      courses.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      figmaGradientDecoration,
                      selectedCourse, 
                      (val) => setState(() => selectedCourse = val),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // 4. زر Search المتدرج
                  Container(
                    width: 225, 
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: figmaGradientDecoration.gradient,
                      border: Border.all(color: const Color(0xB58C8484), width: 1),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedCourse != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ManageCoursesScreen2(selectedCourse: selectedCourse!)),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        "Search",
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
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),

          // 5. الشعار (نفس الموقع والأبعاد)
          Positioned(
            top: -30,
            right: -50,
            child: Image.asset(
              'assets/65.png',
              width: 260,
              height: 260,
              fit: BoxFit.contain,
            ),
          ),

          // 6. أيقونة العودة (الدائرة البيضاء والسهم)
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

  // الدالة المخصصة للـ Dropdown لتطابق الشكل المطلوب
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
          hint: Text(hint, style: const TextStyle(fontFamily: 'IBM Plex Sans', fontStyle: FontStyle.italic, fontSize: 20, color: Color(0xB58C8484))),
          items: items,
          onChanged: onChangedAction,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF005D52)),
        ),
      ),
    );
  }
}