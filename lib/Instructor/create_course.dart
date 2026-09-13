import 'package:flutter/material.dart';
import 'add_information.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  int sectionsCount = 4;
  bool isAdding = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _absenceController = TextEditingController();
  
  List<TextEditingController> _sectionControllers = [];

  @override
  Widget build(BuildContext context) {

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
          // 1. الخلفية الثابتة
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

          // 2. الشعار (خلف الحاوية)
          Positioned(
            top: -30, 
            right: -50, 
            child: Image.asset('assets/65.png', width: 260, height: 260),
          ),

          // 3. زر العودة (خلف الحاوية)
          Positioned(
            top: 60,
            left: 25,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset('assets/12.png', width: 50, height: 50, fit: BoxFit.contain),
            ),
          ),

          // 4. الحاوية البيضاء القابلة للسحب
          DraggableScrollableSheet(
            initialChildSize: 0.8, 
            minChildSize: 0.8,     
            maxChildSize: 1.0,     
            snap: true,
            builder: (context, scrollController) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: figmaGradientDecoration.gradient,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
                ),
                child: ListView(
                  controller: scrollController, // السطر الأهم: لربط حركة السحب بالقائمة
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  children: [
      
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        "Create Course",
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
                    
                    _buildLabel("Course Name"),
                    _buildTextField(hasIcon: true, controller: _nameController),
                    const SizedBox(height: 15),
                    
                    _buildLabel("Course ID"),
                    _buildTextField(controller: _idController),
                    const SizedBox(height: 15),
                    
                    _buildLabel("Absence Percentage"),
                    _buildTextField(controller: _absenceController),
                    
                    const SizedBox(height: 30),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {

                              if (isAdding) {
                              sectionsCount++;
                              if (sectionsCount >= 7) {
                              isAdding = false;
                             }
                              }

                              else {
                              sectionsCount--;
                              if (_sectionControllers.isNotEmpty) {
                              _sectionControllers.removeLast();
                              }

                              if (sectionsCount <= 4) {
                              isAdding = true;
                               }
                              }
                            });
                          },
                          child: const Text(
                            "Add Section",
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans',
                              color: Color(0xFF737373),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(child: Divider(thickness: 0.5, color: Color(0xFF606060))),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // قائمة السكاشن
                    Column(
                      children: List.generate(sectionsCount, (index) {
                        if (_sectionControllers.length <= index) {
                          _sectionControllers.add(TextEditingController());
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Section Name"),
                              Row(
                                children: [
                                  Expanded(child: _buildTextField(hasIcon: true, controller: _sectionControllers[index])),
                                  const SizedBox(width: 10),
                                  _buildMoreInfoButton(context, index), 
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 40),
                    Center(child: _buildCreateButton()),
                    const SizedBox(height: 50), // مساحة إضافية للسحب المريح
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // الدوال المساعدة (Helper Widgets) تبقى كما هي تحت الـ build...
  Widget _buildLabel(String label) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: Text(label, style: const TextStyle(fontFamily: 'Tajawal', color: Color(0xFF005D52), fontSize: 14)),
    );
  }

  Widget _buildTextField({bool hasIcon = false, TextEditingController? controller}) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: const Offset(0, 4))],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFCFDFDD),
          suffixIcon: hasIcon ? const Icon(Icons.edit, color: Color(0xFF005D52), size: 16) : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildMoreInfoButton(BuildContext context, int index) {
    return Container(
      width: 85, height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: const Offset(0, 4))],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          String currentSectionName = _sectionControllers[index].text;
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddInformationScreen(sectionName: currentSectionName)));
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, padding: EdgeInsets.zero),
        child: const Text("More Information", style: TextStyle(fontFamily: 'IBM Plex Sans', color: Color(0xFF737373), fontSize: 8, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildCreateButton() {
    return Container(
      width: 150, height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4, offset: const Offset(0, 4))],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
        ),
        border: Border.all(color: const Color(0xB58C8484), width: 1),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
        child: const Text("Create", style: TextStyle(fontFamily: 'IBM Plex Sans', color: Color(0xFF005D52), fontSize: 24, fontStyle: FontStyle.italic)),
      ),
    );
  }
}