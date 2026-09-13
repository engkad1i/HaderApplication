import 'package:flutter/material.dart';
import 'package:hadeer/Screens/CreateNP.dart';
import 'package:hadeer/Screens/login.dart';

class RestPassword extends StatelessWidget {
  const RestPassword({super.key});

  // ويدجت لبناء مربعات إدخال الرمز الأربعة
  Widget _buildOTPBox(double left) {
    return Positioned(
      left: left,
      top: 601,
      width: 42,
      height: 41,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
          ),
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
            colors: [
              Color(0xFFD9D9D9),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFD9D9D9),
            ],
            stops: [0.0, 0.4375, 0.9279, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Logo Image (64.png)
            Positioned(
              width: 360,
              height: 202,
              left: (MediaQuery.of(context).size.width / 2) - 189,
              top: 59,
              child: Image.asset('assets/64.png', fit: BoxFit.contain),
            ),

            // Back Button (8.png)
            Positioned(
              left: 43,
              top: 59,
              width: 50,
              height: 50,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // العودة للصفحة السابقة
                child: Container(
                  decoration: const BoxDecoration(

                  ),
                  child: Image.asset('assets/8.png'),
                ),
              ),
            ),

            // Main Green Rectangle (Rectangle 15)
            Positioned(
              width: 395,
              height: 675,
              left: 17,
              top: 184,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF29776E),
                      Color(0xFF005D52),
                      Color(0xFF005D52),
                      Color(0xFF29776E),
                    ],
                    stops: [0.0, 0.6971, 0.8413, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
            ),

            // Title: Rest Password
            Positioned(
              width: 378,
              height: 80,
              left: 20,
              top: 221,
              child: const Text(
                "Rest Password",
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

            // White Border Box (Rectangle 20)
            Positioned(
              width: 304,
              height: 394,
              left: 62,
              top: 402,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            // Email Icon Background (Ellipse 15)
            Positioned(
              width: 155,
              height: 125,
              left: 138,
              top: 342,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
                    stops: [0.0, 0.4375, 0.9279, 1.0],
                  ),
                  boxShadow: [BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
                ),
                child: Center(
                  child: Opacity(
                    opacity: 0.74,
                    child: Image.asset('assets/20.png', width: 80, height: 80), // أيقونة الإيميل
                  ),
                ),
              ),
            ),

            // Instruction Text
            Positioned(
              width: 237.9,
              height: 23.23,
              left: 95,
              top: 508,
              child: const Text(
                "Enter The 4 Digit Code ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),

            // OTP Input Boxes (Rectangles 21, 22, 23, 24)
            _buildOTPBox(114),
            _buildOTPBox(166),
            _buildOTPBox(220),
            _buildOTPBox(272),

            // Resend Code (Underlined Text)
            Positioned(
              width: 137.76,
              height: 27.1,
              left: 145,
              top: 667,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Check Your Email Again !")),
                  );
                },
                child: const Text(
                  "Resend Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Color(0xFF9FBAB7),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF9FBAB7),
                  ),
                ),
              ),
            ),

            // Verify Button (Rectangle 18 + Text)
            Positioned(
              width: 165,
              height: 37,
              left: 138,
              top: 703,
              child: GestureDetector(
                onTap: () {
                  // الانتقال لصفحة CreateNP
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateNP(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
                      stops: [0.0, 0.4375, 0.9279, 1.0],
                    ),
                    boxShadow: const [BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Verify",
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