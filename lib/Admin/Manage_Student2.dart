import 'package:flutter/material.dart';

class ManageStudent2 extends StatefulWidget {
  const ManageStudent2({super.key});

  @override
  State<ManageStudent2> createState() => _ManageStudent2State();
}

class _ManageStudent2State extends State<ManageStudent2> {
  final Color primaryGreen = const Color(0xFF005D52);
  final Color lightGreen = const Color(0xFF29776E); // اللون الجديد
  final Color surfaceGray = const Color(0xFFD9D9D9);

  List<Map<String, String>> studentResults = [
    {
      'course': 'SWE312: UI',
      'instId': '001999',
      'secId': 'SWE01',
      'lecId': '1200',
      'attendance': '5%'
    },
    {
      'course': 'SWE312: UI',
      'instId': '001999',
      'secId': 'SWE01',
      'lecId': '1300',
      'attendance': '5%'
    },
  ];

  void _deleteStudent(int index) {
    setState(() {
      studentResults.removeAt(index);
    });
  }

  void _showEditDialog(int index) {
    TextEditingController idController = TextEditingController(text: "2220897"); 
    TextEditingController attController = TextEditingController(
      text: studentResults[index]['attendance']?.replaceAll('%', ''),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogField("Student ID", idController, false),
              const SizedBox(height: 15),
              _buildDialogField("Limit Status", attController, true),
              const SizedBox(height: 25),
              const Divider(height: 1, thickness: 1),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          studentResults[index]['attendance'] = "${attController.text}%";
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Confirm', 
                        style: TextStyle(color: Color(0xFF005D52), fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ),
                  Container(width: 1, height: 40, color: Colors.grey.withOpacity(0.3)),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel', 
                        style: TextStyle(color: Colors.black54, fontSize: 18)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogField(String label, TextEditingController controller, bool isEditable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5),
          child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: TextField(
            controller: controller,
            enabled: isEditable,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              suffixIcon: isEditable ? const Icon(Icons.edit, size: 18, color: Colors.grey) : null,
            ),
          ),
        ),
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightGreen, primaryGreen],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -50, top: 10,
              child: Image.asset('assets/65.png', width: 277, height: 155, fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox()),
            ),
            
            Positioned(
              left: 43, top: 59,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38, height: 38,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Icon(Icons.arrow_back, color: const Color(0xFF212121), size: 20),
                ),
              ),
            ),

            Positioned(
              top: 151, left: 0, right: 0, bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [surfaceGray, Colors.white, Colors.white, surfaceGray],
                  ),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    // تعديل الخط والحجم هنا
                    Text(
                      'Manage Student', 
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans', 
                        fontSize: 40, 
                        fontWeight: FontWeight.bold, 
                        color: primaryGreen
                      )
                    ),
                    const SizedBox(height: 20),
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: _HeaderCell('Courses')),
                          Expanded(flex: 2, child: _HeaderCell('Inst. ID')),
                          Expanded(flex: 2, child: _HeaderCell('Sec. ID')),
                          Expanded(flex: 2, child: _HeaderCell('Lec. ID')),
                          Expanded(flex: 2, child: _HeaderCell('Att. %')),
                          SizedBox(width: 50),
                        ],
                      ),
                    ),
                    Divider(color: primaryGreen, thickness: 1, indent: 15, endIndent: 15),

                    Expanded(
                      child: ListView.builder(
                        itemCount: studentResults.length,
                        itemBuilder: (context, index) {
                          final student = studentResults[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(flex: 3, child: _DataCell(student['course']!)),
                                Expanded(flex: 2, child: _DataCell(student['instId']!)),
                                Expanded(flex: 2, child: _DataCell(student['secId']!)),
                                Expanded(flex: 2, child: _DataCell(student['lecId']!)),
                                Expanded(flex: 2, child: _DataCell(student['attendance']!)),
                                
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _showEditDialog(index),
                                      child: Icon(Icons.edit_outlined, size: 20, color: primaryGreen),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => _deleteStudent(index),
                                      child: Icon(Icons.delete_outline, size: 20, color: primaryGreen),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 160,
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [surfaceGray, Colors.white, Colors.white, surfaceGray],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 24, 
                                fontStyle: FontStyle.italic, 
                                color: primaryGreen, 
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Tajawal'
                              ),
                            ),
                          ),
                        ),
                      ),
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
}

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF005D52)));
  }
}
class _DataCell extends StatelessWidget {
  final String text;
  const _DataCell(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Color(0xFF005D52)));
  }
}