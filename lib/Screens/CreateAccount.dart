import 'package:flutter/material.dart';
import 'package:hadeer/Screens/login.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // متغير لتحديد نوع المستخدم (1 للطالب، 2 للمعلم)
  int selectedUserType = 0;

  // دالة بناء حقول الإدخال (Textfields)
  Widget _buildInputBox({required double top, required double left, required double width, String? hint}) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: 37,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9).withOpacity(0.8),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // دالة بناء نصوص العناوين فوق الحقول
  Widget _buildLabel(String text, double top, double left) {
    return Positioned(
      top: top,
      left: left,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 440,
        height: 956,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
            stops: [0.0, 0.43, 0.92, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Logo Image
            Positioned(
              top: 59,
              left: (MediaQuery.of(context).size.width / 2) - 180,
              child: Image.asset('assets/64.png', width: 360, height: 202),
            ),

            // Back Button (8.png)
            Positioned(
              left: 43,
              top: 59,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // الرجوع للخلف
                child: Image.asset('assets/8.png', width: 50, height: 50),
              ),
            ),

            // Green Background Card
            Positioned(
              top: 184,
              left: 17,
              child: Container(
                width: 395,
                height: 675,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF29776E), Color(0xFF005D52), Color(0xFF005D52), Color(0xFF29776E)],
                    stops: [0.0, 0.69, 0.84, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
            ),

            // White Border Rectangle
            Positioned(
              left: 62,
              top: 301,
              child: Container(
                width: 304,
                height: 495,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            // Page Title
            Positioned(
              top: 221,
              left: 20,
              width: 378,
              child: const Text(
                "Create Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Colors.white,
                  shadows: [Shadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
                ),
              ),
            ),

            // Inputs Labels
            _buildLabel("First Name :", 326, 95),
            _buildLabel("Last Name :", 326, 260),
            _buildLabel("Email :", 398, 95),
            _buildLabel("University Name :", 467, 95),
            _buildLabel("University ID :", 537, 95),
            _buildLabel("Password :", 608, 95),

            // Input Fields
            _buildInputBox(top: 353, left: 88, width: 109), // First Name
            _buildInputBox(top: 353, left: 244, width: 109), // Last Name
            _buildInputBox(top: 425, left: 88, width: 265), // Email
            _buildInputBox(top: 494, left: 88, width: 265), // University Name
            _buildInputBox(top: 564, left: 88, width: 265), // University ID
            _buildInputBox(top: 635, left: 88, width: 265), // Password

            // User Selection (Student)
            Positioned(
              left: 118,
              top: 687,
              child: GestureDetector(
                onTap: () => setState(() => selectedUserType = 1),
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: selectedUserType == 1 ? Colors.white : Colors.transparent,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            _buildLabel("Student", 683, 141),

            // User Selection (Instructor)
            Positioned(
              left: 246,
              top: 687,
              child: GestureDetector(
                onTap: () => setState(() => selectedUserType = 2),
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: selectedUserType == 2 ? Colors.white : Colors.transparent,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            _buildLabel("Instructor", 683, 266),

            // Create Button
            Positioned(
              left: 138,
              top: 725,
              child: GestureDetector(
                onTap: () {
                  // الانتقال لصفحة تسجيل الدخول
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const  LoginPage()),
                  );
                },
                child: Container(
                  width: 165,
                  height: 37,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                      stops: [0.0, 0.43, 0.92, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(0xFF005D52),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}