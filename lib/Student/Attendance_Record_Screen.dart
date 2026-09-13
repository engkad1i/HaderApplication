import 'package:flutter/material.dart';
import 'package:hadeer/Student/Dashboard_s.dart';

class AttendanceRecordScreen extends StatefulWidget {
  const AttendanceRecordScreen({super.key});

  @override
  State<AttendanceRecordScreen> createState() => _AttendanceRecordScreenState();
}

class _AttendanceRecordScreenState extends State<AttendanceRecordScreen> {
  // 1. تعريف القائمة الأصلية للبيانات
  final List<Map<String, dynamic>> allAttendance = [
    {'lecture': 'SWE312: User interface', 'date': '8/12/2025', 'time': '08:00-08:50', 'status': 'Present', 'isAbsent': false},
    {'lecture': 'SWE312: User interface', 'date': '7/12/2025', 'time': '09:00-10:40', 'status': 'Present', 'isAbsent': false},
    {'lecture': 'CYP201: Fundamental of Cybersecurity', 'date': '7/12/2025', 'time': '11:00-12:40', 'status': 'Present', 'isAbsent': false},
    {'lecture': 'SWE312: User interface', 'date': '1/12/2025', 'time': '08:00-08:50', 'status': 'Absent', 'isAbsent': true},
    {'lecture': 'CYP201: Fundamental of Cybersecurity', 'date': '1/12/2025', 'time': '11:00-12:40', 'status': 'Absent', 'isAbsent': true},
  ];

  // 2. القائمة التي ستظهر للمستخدم (ستتغير عند البحث)
  List<Map<String, dynamic>> filteredAttendance = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // في البداية، تظهر كل البيانات
    filteredAttendance = allAttendance;
  }

  // 3. دالة منطق البحث
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = allAttendance;
    } else {
      results = allAttendance
          .where((user) =>
              user["lecture"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredAttendance = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
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
        child: Stack(
          children: [
            Positioned(
              width: 277, height: 155, left: 219, top: 10,
              child: Image.asset('assets/65.png', fit: BoxFit.contain),
            ),
            _buildBackButton(context),
            Positioned(
              width: screenWidth, height: 811, left: 0, top: 151,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                    stops: [0.0, 0.4375, 0.9279, 1.0],
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 22),
                    const Text(
                      'Attendance Record',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                        color: Color(0xFF005D52),
                        shadows: [Shadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)],
                      ),
                    ),
                    const SizedBox(height: 6),
                    
                    // --- حقل البحث الحقيقي ---
                    _buildSearchField(),

                    const SizedBox(height: 19),
                    _buildTableHeader(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(height: 1, width: 426, color: const Color(0xFF005D52)),
                    ),
                    Expanded(
                      child: filteredAttendance.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.only(top: 10, bottom: 20),
                              itemCount: filteredAttendance.length,
                              itemBuilder: (context, index) => _buildDataRow(
                                filteredAttendance[index]['lecture'],
                                filteredAttendance[index]['date'],
                                filteredAttendance[index]['time'],
                                filteredAttendance[index]['status'],
                                isAbsent: filteredAttendance[index]['isAbsent'],
                              ),
                            )
                          : const Center(child: Text("No records found", style: TextStyle(color: Color(0xFF005D52)))),
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

  // تحويلDropdownArea إلى TextField حقيقي للبحث
  Widget _buildSearchField() {
    return Container(
      width: 402,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0x4A3C3C43), width: 2),
        gradient: const LinearGradient(colors: [Color(0xFFD9D9D9), Colors.white, Color(0xFFD9D9D9)]),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: const Offset(0, 4),
            blurRadius: 4,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _runFilter(value), // تفعيل البحث أثناء الكتابة
                decoration: const InputDecoration(
                  hintText: 'Search for courses...',
                  hintStyle: TextStyle(
                    fontFamily: 'IBM Plex Sans',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xB58C8484),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Image.asset('assets/13.png', width: 19.31, height: 23.3, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }

  // --- بقية الـ Widgets المساعدة (لم تتغير) ---
  Widget _buildTableHeader() {
    const headerStyle = TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF005D52));
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('Lecture', style: headerStyle)),
          Expanded(flex: 2, child: Text('Date', textAlign: TextAlign.center, style: headerStyle)),
          Expanded(flex: 3, child: Text('Time', textAlign: TextAlign.center, style: headerStyle)),
          Expanded(flex: 2, child: Text('Status', textAlign: TextAlign.center, style: headerStyle)),
        ],
      ),
    );
  }

  Widget _buildDataRow(String lecture, String date, String time, String status, {bool isAbsent = false}) {
    final dataStyle = TextStyle(
      fontFamily: 'Tajawal', fontWeight: FontWeight.w400, fontSize: 14, height: 1.0, 
      color: isAbsent ? Colors.red : const Color(0xFF005D52),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(lecture, style: dataStyle)),
          Expanded(flex: 2, child: Text(date, textAlign: TextAlign.center, style: dataStyle)),
          Expanded(flex: 3, child: Text(time, textAlign: TextAlign.center, style: dataStyle)),
          Expanded(flex: 2, child: Text(status, textAlign: TextAlign.center, style: dataStyle)),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      width: 50, height: 50, left: 43, top: 59,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Image.asset('assets/12.png', fit: BoxFit.contain),
      ),
    );
  }
}