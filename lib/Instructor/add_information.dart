import 'package:flutter/material.dart';
import 'upload_sl.dart';

class AddInformationScreen extends StatefulWidget {
  final String sectionName;
  const AddInformationScreen({super.key, required this.sectionName});

  @override
  State<AddInformationScreen> createState() => _AddInformationScreenState();
}

class _AddInformationScreenState extends State<AddInformationScreen> {
  // --- Controllers ---
  final TextEditingController _sectionIdController = TextEditingController();
  final List<TextEditingController> _lectureNameControllers = [TextEditingController()];
  final List<TextEditingController> _lectureIdControllers = [TextEditingController()];
  final List<TextEditingController> _lectureNumControllers = [TextEditingController()];

  final List<TextEditingController> _classIdControllers = [TextEditingController()];
  final List<TextEditingController> _dayControllers = [TextEditingController()];
  final List<TextEditingController> _timeControllers = [TextEditingController()];
  final List<TextEditingController> _radiusControllers = [TextEditingController()];
  final List<TextEditingController> _latControllers = [TextEditingController()];
  final List<TextEditingController> _lngControllers = [TextEditingController()];

  int lecturesGroupCount = 1;
  int classesGroupCount = 1;

  // --- Popups ---
  void _showAddStudentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          backgroundColor: const Color(0xFFD9D9D9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text("Add Student", style: TextStyle(fontFamily: 'IBM Plex Sans', fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF005D52))),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildCustomTextField(hint: "Student ID"),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.black45, height: 1),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showSuccessDialog(context);
                      },
                      child: const Text("Add", style: TextStyle(color: Color(0xFF005D52), fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(width: 1, height: 50, color: Colors.black45),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel", style: TextStyle(color: Color(0xFF005D52), fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          backgroundColor: const Color(0xFFD9D9D9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              const Text("The Student Was Added\nSuccessfully", textAlign: TextAlign.center, style: TextStyle(fontFamily: 'IBM Plex Sans', fontSize: 18, color: Color(0xFF005D52))),
              const SizedBox(height: 30),
              const Divider(color: Colors.black45, height: 1),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok", style: TextStyle(color: Color(0xFF005D52), fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // تنسيق الحاوية الموحد
    const BoxDecoration figmaGradientDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
        stops: [0.0, 0.4375, 0.9279, 1.0],
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // 1. الخلفية الخضراء
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

          // 2. الشعار وزر العودة (خلف الحاوية)
          Positioned(
            top: -30, right: -50,
            child: Image.asset('assets/65.png', width: 260, height: 260, fit: BoxFit.contain),
          ),
          Positioned(
            top: 60, left: 25,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset('assets/12.png', width: 50, height: 50, fit: BoxFit.contain),
            ),
          ),

          // 3. الحاوية البيضاء القابلة للسحب (مطابقة لـ CreateCourse)
          DraggableScrollableSheet(
            initialChildSize: 0.8,
            minChildSize: 0.8,
            maxChildSize: 0.94,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: figmaGradientDecoration.gradient,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  children: [
                    const SizedBox(height: 30),
                    // تصميم العنوان المطابق تماماً
                    Center(
                      child: Text(
                        "Add Information",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans',
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF005D52),
                          shadows: [
                            Shadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 4)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    _buildLabel("Section ID"),
                    _buildCustomTextField(hint: "", controller: _sectionIdController),
                    const SizedBox(height: 15),

                    // --- Add Lecture Section ---
                    _buildActionRow("Add Lecture", onTap: () {
                      setState(() {if (lecturesGroupCount == 1) {
      // إذا كانت محاضرة واحدة فقط، أضف الثانية
      lecturesGroupCount++;
    } else {
      // إذا كانت المحاضرة الثانية موجودة، قم بإزالتها
      lecturesGroupCount--;

      // تنظيف الـ Controllers الخاصة بالمجموعة التي تم حذفها لضمان عدم بقاء بيانات في الذاكرة
      if (_lectureNameControllers.length > 1) {
        _lectureNameControllers.removeLast();
        _lectureIdControllers.removeLast();
        _lectureNumControllers.removeLast();
      }
    }
  });
}),
                    Column(
                      children: List.generate(lecturesGroupCount, (index) {
                        if (_lectureNameControllers.length <= index) {
                          _lectureNameControllers.add(TextEditingController());
                          _lectureIdControllers.add(TextEditingController());
                          _lectureNumControllers.add(TextEditingController());
                        }
                        return Column(
                          children: [
                            const SizedBox(height: 15),
                            _buildLabel("Lecture Name"),
                            _buildCustomTextField(hint: "", hasEditIcon: true, controller: _lectureNameControllers[index]),
                            const SizedBox(height: 15),
                            _buildLabel("Lecture ID"),
                            _buildCustomTextField(hint: "", controller: _lectureIdControllers[index]),
                            const SizedBox(height: 15),
                            _buildLabel("Lecture Number"),
                            _buildCustomTextField(hint: "", hasEditIcon: true, controller: _lectureNumControllers[index]),
                            if (index != lecturesGroupCount - 1) const Divider(color: Colors.black12, thickness: 0.5),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 15),

                    // --- Add Class Section ---
                    _buildActionRow("Add Class", onTap: () {
                      setState(() {
                      if (classesGroupCount == 1) {
                     // إذا كان هناك كلاس واحد فقط، نزيد العداد ليظهر Lecture 2
                     classesGroupCount++;
                     } else {
                      // إذا كان هناك أكثر من كلاس (أي Lecture 2 ظاهرة)، ننقص العداد لتختفي
                     classesGroupCount--;
      
                     // اختياري: تنظيف الـ Controllers للمجموعة التي تم حذفها
                     _classIdControllers.removeLast();
                     _dayControllers.removeLast();
                     _timeControllers.removeLast();
                     _radiusControllers.removeLast();
                     _latControllers.removeLast();
                     _lngControllers.removeLast();
                       }
                      });
                     }),
                    Column(
                      children: List.generate(classesGroupCount, (index) {
                        if (_classIdControllers.length <= index) {
                          _classIdControllers.add(TextEditingController());
                          _dayControllers.add(TextEditingController());
                          _timeControllers.add(TextEditingController());
                          _radiusControllers.add(TextEditingController());
                          _latControllers.add(TextEditingController());
                          _lngControllers.add(TextEditingController());
                        }
                        return Column(
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(width: 80, child: _buildLabel("Lecture ${index + 1}")),
                                const SizedBox(width: 10),
                                Expanded(child: _buildCustomTextField(hint: "Class ID", hasEditIcon: true, controller: _classIdControllers[index])),
                              ],
                            ),
                            const SizedBox(height: 15),
                            _buildLabel("Class Schedule ( Day / Time )"),
                            _buildCustomTextField(hint: "Day", hasEditIcon: true, controller: _dayControllers[index]),
                            const SizedBox(height: 10),
                            _buildCustomTextField(hint: "Time", hasEditIcon: true, controller: _timeControllers[index]),
                            const SizedBox(height: 15),
                            _buildLabel("Class Location"),
                            Row(
                              children: [
                                Expanded(child: _buildSmallTextField("Radius", controller: _radiusControllers[index])),
                                const SizedBox(width: 8),
                                Expanded(child: _buildSmallTextField("Latitude", controller: _latControllers[index])),
                                const SizedBox(width: 8),
                                Expanded(child: _buildSmallTextField("Longitude", controller: _lngControllers[index])),
                              ],
                            ),
                            if (index != classesGroupCount - 1) const Divider(color: Colors.black12, thickness: 0.5),
                          ],
                        );
                      }),
                    ),

                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBottomButton("Add Student", 140, onTap: () => _showAddStudentDialog(context)),
                        _buildBottomButton("Upload Student List", 160, onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadVerificationScreen()));
                        }),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(child: _buildDoneButton(context)),
                    const SizedBox(height: 50),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- Helpers ---
  Widget _buildLabel(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15, bottom: 5),
      child: Text(text, style: const TextStyle(fontFamily: 'Tajawal', color: Color(0xFF005D52), fontSize: 14)),
    );
  }

  Widget _buildCustomTextField({required String hint, bool hasEditIcon = false, TextEditingController? controller}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF737373), fontSize: 12, fontStyle: FontStyle.italic),
          filled: true,
          fillColor: const Color(0xFFCFDFDD),
          suffixIcon: hasEditIcon ? const Icon(Icons.edit, color: Color(0xFF005D52), size: 16) : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildSmallTextField(String hint, {TextEditingController? controller}) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFCFDFDD),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF737373), fontSize: 10, fontStyle: FontStyle.italic),
          filled: true,
          fillColor: const Color(0xFFCFDFDD),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildActionRow(String title, {VoidCallback? onTap}) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(title, style: const TextStyle(fontFamily: 'IBM Plex Sans', color: Color(0xFF737373), fontSize: 12, fontStyle: FontStyle.italic, decoration: TextDecoration.underline)),
        ),
        const SizedBox(width: 10),
        const Expanded(child: Divider(color: Color(0xFF606060), thickness: 0.5)),
      ],
    );
  }

  Widget _buildBottomButton(String text, double width, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width, height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: const LinearGradient(colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)], stops: [0.0, 0.4375, 0.9279, 1.0]),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: const Offset(0, 4))],
        ),
        child: Center(child: Text(text, style: const TextStyle(fontFamily: 'IBM Plex Sans', color: Color(0xFF737373), fontSize: 10, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic))),
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return Container(
      width: 150, height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)], stops: [0.0, 0.4375, 0.9279, 1.0]),
        border: Border.all(color: const Color(0xB58C8484), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: const Offset(0, 4))],
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, padding: EdgeInsets.zero),
        child: const Text("Done", style: TextStyle(fontFamily: 'IBM Plex Sans', color: Color(0xFF005D52), fontSize: 24, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic)),
      ),
    );
  }
}