import 'package:flutter/material.dart';
import 'edit_section.dart';

class ManageCoursesScreen2 extends StatefulWidget {
  final String selectedCourse;
  const ManageCoursesScreen2({super.key, required this.selectedCourse});

  @override
  State<ManageCoursesScreen2> createState() => _ManageCoursesScreen2State();
}

class _ManageCoursesScreen2State extends State<ManageCoursesScreen2> {
  late String currentCourse;

  // 1. قمنا بنقل البيانات هنا لكي نتمكن من الحذف منها وتحديث الواجهة
  final Map<String, List<Map<String, String>>> sectionsData = {
    "SWE312": [
      {"name": "SWE312: User interface", "section": "SWE01"},
      {"name": "SWE312: User interface", "section": "SWE02"},
      {"name": "SWE312: User interface", "section": "CS01"},
      {"name": "SWE312: User interface", "section": "CYP01"},
    ],
    "CS01": [
      {"name": "CS01: Introduction", "section": "SEC-A"},
      {"name": "CS01: Introduction", "section": "SEC-B"},
    ],
  };

  @override
  void initState() {
    super.initState();
    currentCourse = widget.selectedCourse;
  }

  @override
  Widget build(BuildContext context) {
    const BoxDecoration figmaContainerDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
        stops: [0.0, 0.4375, 0.9279, 1.0],
      ),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
    );

    return Scaffold(
      body: Stack(
        children: [
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


          Positioned(
            top: -30,
            right: -50,
            child: Image.asset('assets/65.png', width: 260, height: 260, fit: BoxFit.contain),
          ),
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


          DraggableScrollableSheet(
            initialChildSize: 0.8, // تبدأ من 80% من الشاشة
            minChildSize: 0.8,     // أقل حجم
            maxChildSize: 1.0,     // ترتفع لتغطي الشاشة كاملة
            snap: true,
            builder: (context, scrollController) {
              return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: figmaContainerDecoration,
                  child: ListView( // نستخدم ListView لربط السحب
                    controller: scrollController,
                    children: [
                      const SizedBox(height: 48),
                      Text(
                        "Manage Courses",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF005D52),
                          shadows: [Shadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 4)],
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // الدرويداون مع مسافة داخلية
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _buildCustomDropdown(
                          sectionsData.keys.toList(),
                          figmaContainerDecoration,
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // عناوين الجدول مع مسافة لكي لا تلمس الحواف
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: Text("Courses", style: TextStyle(fontFamily: 'Tajawal', color: Color(0xFF005D52), fontSize: 14))),
                            Expanded(flex: 2, child: Text("Section", style: TextStyle(fontFamily: 'Tajawal', color: Color(0xFF005D52), fontSize: 14))),
                            SizedBox(width: 60),
                          ],
                        ),
                      ),
                      
                      const Divider(color: Color(0xFF606060), thickness: 0.5, indent: 25, endIndent: 25),

                      // قائمة الكورسات
                      ListView.builder(
                        shrinkWrap: true, // مهم جداً داخل Draggable
                        physics: const NeverScrollableScrollPhysics(), // لكي لا يتداخل السحب
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        itemCount: sectionsData[currentCourse]?.length ?? 0,
                        itemBuilder: (context, index) {
                          var item = sectionsData[currentCourse]![index];
                          return _buildCourseRow(item['name']!, item['section']!, index);
                        },
                      ),
                      
                      const SizedBox(height: 30),

                      // زر Done
                      Center(
                        child: Padding(
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
                                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
                              ),
                              child: const Center(
                                child: Text(
                                  "Done",
                                  style: TextStyle(fontFamily: 'IBM Plex Sans', fontStyle: FontStyle.italic, fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFF005D52)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDropdown(List<String> items, BoxDecoration decoration) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: decoration.gradient,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: const Offset(0, 4))],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentCourse,
          isExpanded: true,
          style: const TextStyle(fontFamily: 'IBM Plex Sans', fontStyle: FontStyle.italic, fontSize: 20, color: Color(0xFF005D52)),
          items: items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                currentCourse = newValue;
              });
            }
          },
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF005D52)),
        ),
      ),
    );
  }

  // 3. تعديل الدالة لاستقبال رقم السطر (index) وتنفيذ الحذف
  Widget _buildCourseRow(String course, String section, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(course, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 14, color: Color(0xFF005D52)))),
          Expanded(flex: 2, child: Text(section, style: const TextStyle(fontFamily: 'Tajawal', fontSize: 14, color: Color(0xFF005D52)))),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditSectionScreen(sectionName: section)));
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/9.png', // مسار ملف الصورة
                    width: 20, 
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // تعديل أيقونة الحذف لتنفيذ الأمر عند الضغط
              GestureDetector(
                onTap: () {
                  setState(() {
                    sectionsData[currentCourse]!.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete_outline, size: 20, color: Color(0xFF005D52)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}