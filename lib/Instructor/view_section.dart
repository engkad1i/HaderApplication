import 'package:flutter/material.dart';
import 'upload_sl.dart';

class ViewSectionScreen extends StatefulWidget {
  const ViewSectionScreen({super.key});

  @override
  State<ViewSectionScreen> createState() => _ViewSectionScreenState();
}

class _ViewSectionScreenState extends State<ViewSectionScreen> {
  String? selectedCourse;
  String? selectedSection;

  final List<String> coursesList = ["SWE312:\nUser interface", "CS211:\nData Structures", "CYP101:\nSecurity"];
  final List<String> sectionsList = ["SWE01", "SWE02", "CS01", "CYP01"];

  final List<Map<String, dynamic>> studentsData = [
    {"course": "SWE312:\nUser interface", "courseKey": "SWE312", "id": "22200897", "section": "SWE01", "limit": "5%"},
    {"course": "SWE312:\nUser interface", "courseKey": "SWE312", "id": "222008127", "section": "SWE01", "limit": "23%"},
    {"course": "SWE312:\nUser interface", "courseKey": "SWE312", "id": "22200887", "section": "SWE01", "limit": "12%"},
    {"course": "CS211:\nData Structures", "courseKey": "CS211", "id": "22200437", "section": "CS01", "limit": "15%"},
    {"course": "CYP101:\nSecurity", "courseKey": "CYP101", "id": "222006777", "section": "CYP01", "limit": "10%"},
  ];

  Color _getStatusColor(String limitText) {
    try {
      final int percent = int.parse(limitText.replaceAll('%', ''));
      if (percent <= 5) return Colors.greenAccent;
      if (percent <= 10) return const Color(0xFFC9FBB1);
      if (percent <= 15) return Colors.yellow;
      if (percent <= 20) return Colors.orange;
      return Colors.red;
    } catch (e) {
      return Colors.grey;
    }
  }

  // --- 1. الدوال المنبثقة (Popups) ---

  void _showAddStudentDialog(BuildContext context) {
    final TextEditingController idController = TextEditingController();

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
              const Text(
                "Add Student",
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF005D52),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Student ID",
                    hintStyle: const TextStyle(color: Color(0xFF737373), fontSize: 12, fontStyle: FontStyle.italic),
                    filled: true,
                    fillColor: const Color(0xFFCFDFDD),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.black45, height: 1),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (idController.text.isNotEmpty && selectedCourse != null) {
                          setState(() {
                           String shortKey = selectedCourse!.split(':')[0].trim();
                            studentsData.add({
                              "course": selectedCourse ?? "Unknown",
                              "courseKey": shortKey,
                              "id": idController.text,
                              "section": selectedSection ?? "N/A",
                              "limit": "0%",
                            });
                          });
                          Navigator.pop(context);
                          _showSuccessDialog(context);
                        }
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
              const Text(
                "The Student Was Added\nSuccessfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans',
                  fontSize: 18,
                  color: Color(0xFF005D52),
                ),
              ),
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

  void _showEditStudentDialog(BuildContext context, Map<String, dynamic> student) {
    final TextEditingController limitController = TextEditingController(text: student['limit']);

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildPopupTextField(label: "Student ID", hint: student['id'], enabled: false),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildPopupTextField(
                  label: "Limit Status",
                  hint: "Example: 15%",
                  controller: limitController,
                  hasEditIcon: true,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.black45, height: 1),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          student['limit'] = limitController.text;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Confirm", style: TextStyle(color: Color(0xFF005D52), fontSize: 18, fontWeight: FontWeight.bold)),
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

  // --- 2. واجهة التطبيق (UI Build) ---

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

    List<Map<String, dynamic>> filteredList = studentsData.where((s) {
  bool matchCourse = selectedCourse == null || s['courseKey'] == selectedCourse!.split(':')[0].trim();
  if (selectedCourse != null) {
    // نأخذ الرمز المختصر من القائمة (مثل SWE312) ونقارنه بـ courseKey للطالب
    String selectedKey = selectedCourse!.split(':')[0].trim(); 
    matchCourse = s['courseKey'] == selectedKey;
  }
  
  bool matchSection = selectedSection == null || s['section'] == selectedSection;
  return matchCourse && matchSection;
}).toList();

    return Scaffold(
      body: Stack(
        children: [
          // الخلفية الخضراء
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

          // الشعار الخلفي
          Positioned(
            top: -30,
            right: -50,
            child: Image.asset('assets/65.png', width: 260, height: 260, fit: BoxFit.contain),
          ),

          // زر العودة الخلفي
          Positioned(
            top: 60,
            left: 25,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset('assets/12.png', width: 50, height: 50, fit: BoxFit.contain),
            ),
          ),

          // الحاوية البيضاء القابلة للسحب
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
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "View Section",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans',
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF005D52),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _buildDropdown("Select Course", coursesList, selectedCourse, (val) => setState(() => selectedCourse = val)),
                          const SizedBox(height: 15),
                          _buildDropdown("Select Section", sectionsList, selectedSection, (val) => setState(() => selectedSection = val)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTableHeader(),
                    const Divider(color: Color(0xFF606060), thickness: 0.5, indent: 20, endIndent: 20),
                    
                    // استخدام ListView داخل ListView يتطلب shrinkWrap
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) => _buildStudentRow(filteredList[index]),
                    ),
                    
                    const SizedBox(height: 20),
                    _buildActionButtons(figmaGradientDecoration, context),
                    
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50, top: 20),
                      child: Center(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 225,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: figmaGradientDecoration.gradient,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: const Color(0xB58C8484)),
                              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
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

  // --- 3. الأدوات المساعدة (Helper Widgets) ---

  Widget _buildDropdown(String hint, List<String> items, String? value, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(fontFamily: 'IBM Plex Sans', fontStyle: FontStyle.italic, fontSize: 20, color: Color(0xB58C8484))),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF005D52)),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Courses", style: TextStyle(fontFamily: 'Tajawal', fontSize: 14, color: Color(0xFF005D52))),
          Text("Student ID", style: TextStyle(fontFamily: 'Tajawal', fontSize: 14, color: Color(0xFF005D52))),
          Text("Section ID", style: TextStyle(fontFamily: 'Tajawal', fontSize: 14, color: Color(0xFF005D52))),
          Text("Limit Status", style: TextStyle(fontFamily: 'Tajawal', fontSize: 14, color: Color(0xFF005D52))),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildStudentRow(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(data['course'], style: const TextStyle(fontFamily: 'Tajawal', fontSize: 13, color: Color(0xFF005D52)))),
          Expanded(child: Center(child: Text(data['id'], style: const TextStyle(fontFamily: 'Tajawal', fontSize: 13, color: Color(0xFF005D52))))),
          Expanded(child: Center(child: Text(data['section'], style: const TextStyle(fontFamily: 'Tajawal', fontSize: 13, color: Color(0xFF005D52))))),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data['limit'], style: const TextStyle(fontFamily: 'Tajawal', fontSize: 13, color: Color(0xFF005D52))),
                const SizedBox(width: 5),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: _getStatusColor(data['limit']),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _showEditStudentDialog(context, data),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Image.asset('assets/9.png', width: 18, height: 18, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              setState(() {
                studentsData.removeWhere((student) => student['id'] == data['id']);
              });
            },
            child: const Icon(Icons.delete_outline, size: 18, color: Color(0xFF005D52)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BoxDecoration dec, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => _showAddStudentDialog(context),
          child: _smallBtn("Add Student", dec),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UploadVerificationScreen()),
            );
          },
          child: _smallBtn("Upload Student List", dec),
        ),
      ],
    );
  }

  Widget _smallBtn(String text, BoxDecoration dec) {
    return Container(
      width: 140,
      height: 35,
      decoration: BoxDecoration(
        gradient: dec.gradient,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xB58C8484)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans',
            fontStyle: FontStyle.italic,
            fontSize: 14,
            color: Color(0xFF005D52),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupTextField({required String label, required String hint, TextEditingController? controller, bool hasEditIcon = false, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("   $label", style: const TextStyle(color: Color(0xFF005D52), fontSize: 10, fontStyle: FontStyle.italic)),
        const SizedBox(height: 4),
        Container(
          height: 35,
          decoration: BoxDecoration(
            color: const Color(0xFFCFDFDD),
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF737373), fontSize: 12),
              suffixIcon: hasEditIcon ? const Icon(Icons.edit, size: 14, color: Color(0xFF005D52)) : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}