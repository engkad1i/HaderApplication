import 'package:flutter/material.dart';
import 'package:hadeer/Screens/login.dart';

class CreateNP extends StatefulWidget {
  const CreateNP({super.key});

  @override
  State<CreateNP> createState() => _CreateNPState();
}

class _CreateNPState extends State<CreateNP> {
  // حالة رؤية كلمة المرور
  bool _isObscured = true;

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
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: const BoxDecoration(

                  ),
                  child: Image.asset('assets/8.png'),
                ),
              ),
            ),

            // Main Green Box (Rectangle 15)
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
                    colors: [Color(0xFF29776E), Color(0xFF005D52), Color(0xFF005D52), Color(0xFF29776E)],
                    stops: [0.0, 0.7163, 0.8606, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
            ),

            // Title: Create new Password
            Positioned(
              width: 378,
              height: 120,
              left: 20,
              top: 220,
              child: const Text(
                "Create New Password",
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

            // Lock Icon Background (Ellipse 15)
            Positioned(
              width: 155,
              height: 125,
              left: 134,
              top: 342,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                    stops: [0.0, 0.4375, 0.9279, 1.0],
                  ),
                  boxShadow: [BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
                ),
                child: Center(
                  child: Image.asset('assets/21.png', width: 80, height: 80), // أيقونة القفل
                ),
              ),
            ),

            // Instruction Text
            Positioned(
              width: 265,
              height: 40,
              left: 85,
              top: 490,
              child: const Text(
                "Your New Password Must \nBe Different From Previously Used Password",                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),

            // Password Label
            Positioned(
              width: 137.76,
              height: 27.1,
              left: 91,
              top: 572,
              child: const Text(
                "New Password :",
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),

            // Password Input (Rectangle 16)
            Positioned(
              width: 265,
              height: 37,
              left: 79,
              top: 610,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  obscureText: _isObscured, // التحكم في النجوم
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      child: Container(
                        width: 45, // مساحة الحاوية
                        height: 45,
                        alignment: Alignment.center,
                        child: Image.asset(
                          _isObscured ? 'assets/22.png' : 'assets/23.png',
                          // تحكم منفصل لكل أيقونة هنا:
                          width: _isObscured ? 25 : 30,  // إذا كانت مغلقة 30، وإذا كانت مفتوحة 35
                          height: _isObscured ? 25 : 30, // إذا كانت مغلقة 30، وإذا كانت مفتوحة 35
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Confirm Button (Rectangle 18)
            Positioned(
              width: 165,
              height: 37,
              left: 138,
              top: 703,
              child: GestureDetector(
                onTap: () {
                  // الانتقال لصفحة تسجيل الدخول
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const  LoginPage()),
                  );
                },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD9D9D9), Colors.white, Colors.white, Color(0xFFD9D9D9)],
                    stops: [0.0, 0.4375, 0.9279, 1.0],
                  ),
                  boxShadow: const [BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4)],
                  borderRadius: BorderRadius.circular(40),
                ),
              ),

            ),
    ),
            // Confirm Text
            Positioned(
              width: 236,
              height: 80,
              left: 102,
              top: 682,
              child: GestureDetector(
                onTap: () {
                  // الانتقال لصفحة تسجيل الدخول
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const  LoginPage()),
                  );
                },
              child: const Center(
                child: Text(
                  "confirm",
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