import 'package:flutter/material.dart';
import 'package:hadeer/Admin/View_Section_page.dart';

class ManageInstructor2 extends StatefulWidget {
  const ManageInstructor2({super.key});

  @override
  State<ManageInstructor2> createState() => _ManageInstructor2State();
}

class _ManageInstructor2State extends State<ManageInstructor2> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF005D52);
    const lightGreen = Color(0xFF29776E); // اللون الأخضر الفاتح الجديد

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // --- تعديل الخلفية الخضراء العلوية ---
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightGreen, primaryGreen],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -50, 
              top: 10,
              child: Image.asset(
                'assets/65.png',
                width: 277,
                height: 155,
                fit: BoxFit.contain,
              ),
            ),

            Positioned(
              left: 43,
              top: 59,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                  ),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF212121), size: 20),
                ),
              ),
            ),

            Positioned(
              top: 151,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                // --- تعديل الخلفية البيضاء (المنطقة السفلية) ---
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                    stops: [0, 0.4375, 0.9279, 1],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    
                    // --- تعديل الخط: IBM Plex Sans بحجم 40 ---
                    Text(
                      'Manage Instructor',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: primaryGreen,
                        shadows: [
                          const Shadow(
                            color: Colors.black26, 
                            offset: Offset(0, 4), 
                            blurRadius: 4
                          )
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),

                    // حقل البحث
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white, // أبيض صافي كما طلبتِ سابقاً
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: const Color(0x4A3C3C43), width: 1.2),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))],
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Instructor ID', 
                            hintStyle: TextStyle(
                              fontFamily: 'Tajawal',
                              fontStyle: FontStyle.italic,
                              color: Color(0xB58C8484),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(Icons.search, color: primaryGreen),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // الجدول
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            _buildHeaderRow(),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Divider(color: primaryGreen, thickness: 1.5),
                            ),
                            _buildDataRow(context, 'SWE312: UI', 'SWE01', '48', '1200', '1300', '25%'),
                            _buildDataRow(context, 'SWE312: UI', 'SWE02', '43', '1201', '1301', '25%'),
                          ],
                        ),
                      ),
                    ),

                    // زر Done
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xB58C8484)),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
                          ),
                          child: const Center(
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontFamily: 'Tajawal', 
                                fontWeight: FontWeight.bold, 
                                fontStyle: FontStyle.italic,
                                fontSize: 24, 
                                color: primaryGreen
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

  // الدوال المساعدة للجدول (تبقى كما هي لضمان عمل البيانات)
  Widget _buildHeaderRow() {
    const headerStyle = TextStyle(color: Color(0xFF005D52), fontSize: 10, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          const Expanded(flex: 3, child: Text('Courses ID', style: headerStyle)),
          const Expanded(flex: 2, child: Text('Section ID', style: headerStyle)),
          const Expanded(flex: 1, child: Text('NOS', style: headerStyle)),
          Expanded(flex: 3, child: Column(
            children: [
              const Text('Lecture IDs', style: headerStyle),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('1', style: headerStyle.copyWith(fontSize: 8)),
                  const SizedBox(width: 20),
                  Text('2', style: headerStyle.copyWith(fontSize: 8)),
                ],
              )
            ],
          )),
          const Expanded(flex: 2, child: Text('Attendance %', style: headerStyle)),
          const SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildDataRow(BuildContext context, String course, String sec, String nos, String l1, String l2, String atten) {
    const dataStyle = TextStyle(fontSize: 10, color: Color(0xFF005D52));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(course, style: dataStyle)),
          Expanded(flex: 2, child: Text(sec, style: dataStyle)),
          Expanded(flex: 1, child: Text(nos, style: dataStyle)),
          Expanded(flex: 3, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l1, style: dataStyle),
              Container(
                height: 15,
                width: 1,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              Text(l2, style: dataStyle),
            ],
          )),
          Expanded(flex: 2, child: Text(atten, style: dataStyle)),
          
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSectionPage(sectionId: sec)));
            },
            child: Container(
              width: 50, height: 22,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                ),
                borderRadius: BorderRadius.circular(20), 
                border: Border.all(color: const Color(0xB58C8484)),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))],
              ),
              child: const Center(child: Text('View', style: TextStyle(fontSize: 9, color: Color(0xFF005D52), fontStyle: FontStyle.italic, fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }
}