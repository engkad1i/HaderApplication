import 'package:flutter/material.dart';
import 'package:hadeer/Instructor/Dashboard_i.dart';


class ProfileI extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileI> {
  // تعريف وحدات التحكم للنصوص لتمكين التعديل والحفظ
  final TextEditingController _firstNameController = TextEditingController(
      text: "Tamara");
  final TextEditingController _lastNameController = TextEditingController(
      text: "Alanzi");
  final TextEditingController _emailController = TextEditingController(
      text: "");
  final TextEditingController _uniNameController = TextEditingController(
      text: "");
  final TextEditingController _uniIdController = TextEditingController(
      text: "");
  final TextEditingController _passwordController = TextEditingController(
      text: "");

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
            colors: [
              Color(0xFFD9D9D9),
              Colors.white,
              Colors.white,
              Color(0xFFD9D9D9)
            ],
            stops: [0.0, 0.4375, 0.9279, 1.0],
          ),
        ),
        child: Stack(
          children: [
// الشعار
            Positioned(
              right: -80,
              top: 59,
              child: Center(
                child: Image.asset('assets/64.png', width: 360, height: 202),
              ),
            ),

            // زر الرجوع
            Positioned(
              left: 43,
              top: 65,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // العودة لـ AdminDashboard
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/8.png'),
                ),
              ),
            ),

            // الخلفية الخضراء الكبيرة (Rectangle 15)
            Positioned(
              left: 17,
              top: 184,
              child: Container(
                width: 395,
                height: 675,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF29776E),
                      Color(0xFF005D52),
                      Color(0xFF005D52),
                      Color(0xFF29776E)
                    ],
                    stops: [0.0, 0.6923, 0.8462, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
            ),

            // الإطار الأبيض الداخلي (Rectangle 20)
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

            // عنوان الصفحة (Profile)
            Positioned(
              left: 20,
              top: 221,
              child: Container(
                width: 378,
                child: Text(
                  "Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Colors.black26)
                    ],
                  ),
                ),
              ),
            ),

            // حقول الإدخال
            _buildLabel("First Name :", 95, 326),
            _buildTextField(_firstNameController, 88, 353, width: 109),

            _buildLabel("Last Name :", 260, 326),
            _buildTextField(_lastNameController, 244, 353, width: 109),

            _buildLabel("Email :", 95, 398),
            _buildTextField(_emailController, 88, 425, width: 265),

            _buildLabel("University Name :", 95, 467),
            _buildTextField(_uniNameController, 88, 494, width: 265),

            _buildLabel("University ID :", 95, 537),
            _buildTextField(_uniIdController, 88, 564, width: 265),

            _buildLabel("Password :", 95, 608),
            _buildTextField(
                _passwordController, 88, 635, width: 265, isPassword: true),

            // زر الحفظ (Done)
            Positioned(
              left: 138,
              top: 725,
              child: InkWell(
                onTap: () {
                  // هنا يتم تنفيذ عملية الحفظ
                  print("Saved: ${_firstNameController.text}");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Changes Saved Successfully!")),
                  );
                },
          child: Container(
                  width: 165,
                  height: 37,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFD9D9D9), Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.grey.withOpacity(0.7)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans',
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
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


  // ودجت مخصصة للعناوين (Label)
  Widget _buildLabel(String text, double left, double top) {
    return Positioned(
      left: left,
      top: top,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  // ودجت مخصصة لحقول النص (TextField)
  Widget _buildTextField(TextEditingController controller, double left,
      double top, {double width = 265, bool isPassword = false}) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: width,
        height: 37,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9).withOpacity(0.8),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                style: TextStyle(fontSize: 13, color: Colors.black87),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            Image.asset('assets/9.png', width: 16, height: 16),
            // أيقونة التعديل
          ],
        ),
      ),
    );
  }
}