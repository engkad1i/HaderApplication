import 'package:flutter/material.dart';
import 'Manage_Instructor2.dart';
import 'package:hadeer/Admin/Dashboard_A.dart';
class ManageInstructorPage extends StatefulWidget {
  const ManageInstructorPage({super.key});

  @override
  State<ManageInstructorPage> createState() => _ManageInstructorPageState();
}

class _ManageInstructorPageState extends State<ManageInstructorPage> {
  String? errorMsg;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF005D52);
    const lightGreen = Color(0xFF29776E);
    const surfaceGray = Color(0xFFD9D9D9);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
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
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      surfaceGray,
                      Colors.white,
                      Colors.white,
                      surfaceGray,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 35),
                    // --- التعديل هنا: الخط والحجم المطلوب ---
                    const Text(
                      'Manage Instructor',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 40, // تم تغيير الحجم لـ 40
                        color: primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: errorMsg == null ? 60 : 80,
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: errorMsg == null 
                                ? Colors.grey.withOpacity(0.3) 
                                : Colors.red,
                            width: 1.2,
                          ),
                          boxShadow: const [BoxShadow(color: Colors.
                          black12, blurRadius: 4, offset: Offset(0, 4))],
                        ),
                        child: Center(
                          child: TextField(
                            controller: _controller,
                            onChanged: (value) {
                              setState(() {
                                errorMsg = value.isEmpty ? "ID can't be empty" : null;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Instructor ID',
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
                                  icon: const Icon(Icons.search, color: primaryGreen),
                                  onPressed: () {
                                    if (_controller.text.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ManageInstructor2()),
                                      );
                                    } else {
                                      setState(() => errorMsg = "Please enter ID first");
                                    }
                                  },
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

                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: InkWell(
                        onTap: () {
                          if (_controller.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ManageInstructor2()),
                            );
                          } else {
                            setState(() => errorMsg = "Please enter ID first");
                          }
                        },
                        child: Container(
                          width: 160,
                          height: 55,
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