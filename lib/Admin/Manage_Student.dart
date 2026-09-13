import 'package:flutter/material.dart';
// تأكدي من مسمى الملف الفعلي لديك لصفحة النتائج
import 'manage_student2.dart'; 

class ManageStudentSearch extends StatefulWidget {
  const ManageStudentSearch({super.key});

  @override
  State<ManageStudentSearch> createState() => _ManageStudentSearchState();
}

class _ManageStudentSearchState extends State<ManageStudentSearch> {
  final TextEditingController _idController = TextEditingController();
  String? errorMsg;

  void _handleSearch() {
    if (_idController.text.trim().isNotEmpty) {
      setState(() {
        errorMsg = null;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ManageStudent2()),
      );
    } else {
      setState(() {
        errorMsg = "Please enter ID first";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // الألوان الموحدة
    const primaryGreen = Color(0xFF005D52); 
    const lightGreen = Color(0xFF29776E); // اللون الموحد الجديد
    const surfaceGray = Color(0xFFD9D9D9);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // --- الخلفية الخضراء الموحدة ---
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
              right: -50, top: 10,
              child: Image.asset(
                'assets/65.png',
                width: 277, height: 155, fit: BoxFit.contain,
                errorBuilder: (c, e, s) => const SizedBox(),
              ),
            ),

            Positioned(
              left: 43, top: 59,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38, height: 38,
                  decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                  ),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF212121), size: 20),
                ),
              ),
            ),

            Positioned(
              top: 151, left: 0, right: 0, bottom: 0,
              child: Container(
                // --- الخلفية البيضاء الموحدة (المنطقة السفلية) ---
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [surfaceGray, Colors.white, Colors.white, surfaceGray],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70), topRight: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    
                    // --- تعديل الخط: IBM Plex Sans بحجم 40 ---
                    const Text(
                      'Manage Student',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans', 
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: primaryGreen,
                      ),
                    ),

                    const SizedBox(height: 50),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: errorMsg == null ? 60 : 80,
                        decoration: BoxDecoration(
                          color: Colors.white, // أبيض صافي
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: errorMsg != null ? Colors.red : Colors.grey.withOpacity(0.3),
                            width: 1.2
                          ),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))],
                        ),
                        child: Center(
                          child: TextField(
                            controller: _idController,
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              if (val.isNotEmpty && errorMsg != null) {
                                setState(() => errorMsg = null);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Student ID',
                              errorText: errorMsg,
                              errorStyle: const TextStyle(color: Colors.red, fontSize: 11, height: 0.1),
                              hintStyle: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontStyle: FontStyle.italic,
                                color: Color(0xB58C8484),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: IconButton(
                                  onPressed: _handleSearch,
                                  icon: const Icon(Icons.search, color: primaryGreen, size: 28),
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // زر Search الموحد بالتدرج والظل
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: InkWell(
                        onTap: _handleSearch,
                        child: Container(
                          width: 160, height: 55,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [surfaceGray, Colors.white, Colors.white, surfaceGray],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
                          ),
                          child: const Center(
                            child: Text(
                              'Search',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: primaryGreen,
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