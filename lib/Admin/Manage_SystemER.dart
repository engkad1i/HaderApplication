import 'package:flutter/material.dart';
import 'manage_systemER2.dart'; 

class SystemReportsPage extends StatefulWidget {
  const SystemReportsPage({super.key});

  @override
  State<SystemReportsPage> createState() => _SystemReportsPageState();
}

class _SystemReportsPageState extends State<SystemReportsPage> {
  List<Map<String, String>> reports = [
    {"name": "Nourah Khalid", "role": "Student", "id": "2224005", "title": "Technical issues", "date": "7/12/2025", "time": "08:00 PM", "status": "In Progress"},
    {"name": "Areej Fahad", "role": "Instructor", "id": "1115002", "title": "Functionality Issues", "date": "7/12/2025", "time": "09:00 AM", "status": "In Progress"},
    {"name": "Amani Hamad", "role": "Instructor", "id": "1116003", "title": "Technical issues", "date": "25/12/2025", "time": "11:00 PM", "status": "Resolved"},
    {"name": "Retaj Alazani", "role": "Student", "id": "2227009", "title": "Interface issues", "date": "1/12/2025", "time": "03:00 PM", "status": "Pending"},
  ];

  final Color primaryGreen = const Color(0xFF005D52);
  final Color lightGreen = const Color(0xFF29776E); // اللون الموحد الجديد
  final Color surfaceGray = const Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // --- الخلفية الخضراء الموحدة ---
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
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF212121), size: 20),
                ),
              ),
            ),
            Positioned(
              top: 151, left: 0, right: 0, bottom: 0,
              child: Container(
                // --- الخلفية البيضاء/الرمادية الموحدة ---
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
                    // --- تعديل الخط والحجم للعنوان ---
                    Text(
                      'Manage System Error Reports', 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans', 
                        fontWeight: FontWeight.bold, 
                        fontSize: 40, // الحجم المطلوب
                        color: primaryGreen
                      )
                    ),
                    const SizedBox(height: 25),
                    _buildTableHeader(),
                    Divider(color: primaryGreen, thickness: 1, indent: 15, endIndent: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          return _buildReportRow(index);
                        },
                        ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 160, // توحيد عرض الزر مع الصفحات السابقة
                          height: 55, // توحيد ارتفاع الزر
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

  Widget _buildTableHeader() {
    const headerStyle = TextStyle(color: Color(0xFF005D52), fontSize: 10, fontWeight: FontWeight.bold);
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text("Name", style: headerStyle)),
          Expanded(child: Text("Role", style: headerStyle)),
          Expanded(flex: 2, child: Text("Title", style: headerStyle)),
          Expanded(child: Text("Date", style: headerStyle)),
          Expanded(child: Text("Time", style: headerStyle)),
          Expanded(child: Text("Status", style: headerStyle)),
          SizedBox(width: 30),
        ],
      ),
    );
  }

  Widget _buildReportRow(int index) {
    final report = reports[index];
    const contentStyle = TextStyle(color: Color(0xFF005D52), fontSize: 10);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(report['name']!, style: contentStyle)),
          Expanded(child: Text(report['role']!, style: contentStyle)),
          Expanded(flex: 2, child: Text(report['title']!, style: contentStyle)),
          Expanded(child: Text(report['date']!, style: contentStyle)),
          Expanded(child: Text(report['time']!, style: contentStyle)),
          Expanded(child: Text(report['status']!, style: contentStyle)),
          GestureDetector(
            onTap: () async {
              final String? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageSystemER2(
                    name: report['name']!,
                    role: report['role']!,
                    id: report['id']!,
                    title: report['title']!,
                    currentStatus: report['status']!,
                  ),
                ),
              );
              if (result != null) {
                setState(() {
                  reports[index]['status'] = result;
                });
              }
            },
            child: const Icon(Icons.edit_outlined, size: 15, color: Color(0xFF005D52)),
          ),
          ],
      ),
    );
  }
}