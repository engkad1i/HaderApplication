import 'package:flutter/material.dart';

// الألوان الموحدة للهوية
const Color primaryGreen = Color(0xFF005D52);
const Color lightGreen = Color(0xFF29776E);
const Color surfaceGray = Color(0xFFD9D9D9);

// --- صفحة الرفع (UploadPage) ---
class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

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
            // تم تعديل الألوان هنا لتطابق الهوية الموحدة
            colors: [lightGreen, primaryGreen],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -50, top: 10,
              child: Image.asset('assets/65.png', width: 277, height: 155, fit: BoxFit.contain, 
                errorBuilder: (c, e, s) => const SizedBox()),
            ),
            Positioned(
              left: 43, top: 59,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38, height: 38,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF212121), size: 20),
                ),
              ),
            ),
            Positioned(
              top: 151, left: 0, right: 0, bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    const Text("Upload Verification Doc", 
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF11181C))),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 152,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDBDBDB)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(color: Color(0xFFCFDFDD), shape: BoxShape.circle),
                              child: const Icon(Icons.cloud_upload_outlined, color: primaryGreen, size: 28),
                            ),
                            const SizedBox(height: 10),
                            const Text("Drop your files here or Browse", style: TextStyle(fontSize: 14)),
                            const Text("SVG, PNG, JPG (max. 800x400px)", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: _buildStyledButton("Done", () => Navigator.pop(context), width: 150),
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

  Widget _buildStyledButton(String label, VoidCallback onTap, {double width = 140}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width, height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFD9D9D9), Colors.white]),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))],
        ),
        child: Center(child: Text(label, style: const TextStyle(color: primaryGreen, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18))),
      ),
    );
  }
}

// --- الصفحة الأساسية (ViewSectionPage) ---
class ViewSectionPage extends StatefulWidget {
  final String sectionId;
  const ViewSectionPage({super.key, required this.sectionId});

  @override
  State<ViewSectionPage> createState() => _ViewSectionPageState();
}

class _ViewSectionPageState extends State<ViewSectionPage> {
  int selectedStudentIndex = -1;

  List<Map<String, dynamic>> students = [
    {'course': 'SWE312', 'section': 'SWE 1', 'id': '22200997', 'limit': '15%'},
    {'course': 'SWE312', 'section': 'SWE 1', 'id': '22200867', 'limit': '12%'},
    {'course': 'SWE312', 'section': 'SWE 1', 'id': '22200677', 'limit': '8%'},
    {'course': 'SWE312', 'section': 'SWE 1', 'id': '22200577', 'limit': '19%'},
  ];

  Color _getStatusColor(String limitText) {
    try {
      final int percent = int.parse(limitText.replaceAll('%', ''));
      if (percent <= 10) return Colors.greenAccent;
      if (percent <= 15) return Colors.yellow;
      return Colors.orange;
    } catch (e) {
      return Colors.grey;
    }
  }

  void _showAddStudentDialog() {
    TextEditingController idController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: const Color(0xFFD9D9D9),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Add Student", style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen)),
            const SizedBox(height: 15),
            _buildDialogField("Student ID", null, controller: idController),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: TextButton(onPressed: () {
                  if(idController.text.isNotEmpty){
                    setState(() => students.add({'course': 'SWE312', 'section': 'SWE 1', 'id': idController.text, 'limit': '0%'}));
                    Navigator.pop(context);
                  }
                }, child: const Text("Add", style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold)))),
                Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.black54)))),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showEditDialog(int index) {
    TextEditingController limitController = TextEditingController(text: students[index]['limit']);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: const Color(0xFFD9D9D9),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogField("Student ID", students[index]['id'], enabled: false),
            const SizedBox(height: 10),
            _buildDialogField("Limit State (e.g. 15%)", null, controller: limitController, isEdit: true),
            const SizedBox(height: 15),
            TextButton(onPressed: () {
              setState(() {
                students[index]['limit'] = limitController.text;
              });
              Navigator.pop(context);
            }, child: const Text("Confirm", style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
  Widget _buildDialogField(String label, String? value, {TextEditingController? controller, bool enabled = true, bool isEdit = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        TextField(
          controller: controller ?? TextEditingController(text: value),
          enabled: enabled,
          decoration: InputDecoration(
            filled: true, fillColor: Colors.white,
            suffixIcon: isEdit ? const Icon(Icons.edit, size: 16, color: primaryGreen) : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // تم تعديل تدريج الألوان هنا أيضاً
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [lightGreen, primaryGreen], 
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter
          )
        ),
        child: Stack(
          children: [
            Positioned(right: -50, top: 10, child: Image.asset('assets/65.png', width: 277, height: 155, errorBuilder: (c,e,s) => const SizedBox())),
            Positioned(left: 43, top: 59, child: InkWell(onTap: () => Navigator.pop(context), child: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.arrow_back, color: Colors.black)))),
            Positioned(
              top: 151, left: 0, right: 0, bottom: 0,
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70))),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    const Text('View Section', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: primaryGreen)),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        width: double.infinity, padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey.withOpacity(0.5))),
                        child: selectedStudentIndex != -1
                            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                const Text('Course Name : User Interface (SWE312)', style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold)),
                                Text('Section : ${students[selectedStudentIndex]['section']}', style: const TextStyle(color: primaryGreen)),
                                Text('Student ID : ${students[selectedStudentIndex]['id']}', style: const TextStyle(color: primaryGreen)),
                                Text('Limit State : ${students[selectedStudentIndex]['limit']}', style: const TextStyle(color: primaryGreen)),
                              ])
                            : const Center(child: Text('Select a student or click course')),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _buildHeaderRow(),
                          const Divider(color: primaryGreen),
                          ...students.asMap().entries.map((entry) => _buildDataRow(entry.key, entry.value)).toList(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStyledButton("Add Student", _showAddStudentDialog, width: 140),
                          _buildStyledButton("Upload List", () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadPage()));
                          }, width: 140),
                        ],
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(bottom: 30), child: _buildStyledButton("Done", () => Navigator.pop(context), width: 150)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledButton(String label, VoidCallback onTap, {double width = 140}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width, height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFD9D9D9), Colors.white]),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))],
        ),
        child: Center(child: Text(label, style: const TextStyle(color: primaryGreen, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 14))),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return const Row(children: [
      Expanded(flex: 2, child: Text('Course', style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold, fontSize: 11))),
      Expanded(flex: 2, child: Text('Section ID', style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold, fontSize: 11))),
      Expanded(flex: 3, child: Text('Student ID', style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold, fontSize: 11))),
      Expanded(flex: 2, child: Text('Limit', style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold, fontSize: 11))),
      SizedBox(width: 60),
    ]);
  }

  Widget _buildDataRow(int index, Map data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: InkWell(onTap: () => setState(() => selectedStudentIndex = index), child: Text(data['course'], style: const TextStyle(fontSize: 10, color: primaryGreen)))),
          Expanded(flex: 2, child: Text(data['section'], style: const TextStyle(fontSize: 10, color: primaryGreen))),
          Expanded(flex: 3, child: Text(data['id'], style: const TextStyle(fontSize: 10, color: primaryGreen))),
          Expanded(flex: 1, child: Text(data['limit'], style: const TextStyle(fontSize: 10, color: primaryGreen))),
          Container(
            width: 14, height: 14, 
            decoration: BoxDecoration(
              color: _getStatusColor(data['limit']), 
              shape: BoxShape.circle
            )
          ),
          const SizedBox(width: 15),
          GestureDetector(onTap: () => setState(() => students.removeAt(index)), child: const Icon(Icons.delete_outline, size: 18, color: primaryGreen)),
          const SizedBox(width: 8),
          GestureDetector(onTap: () { setState(() => selectedStudentIndex = index); _showEditDialog(index); }, child: const Icon(Icons.edit_outlined, size: 18, color: primaryGreen)),
        ],
      ),
    );
  }
}