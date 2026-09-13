import 'package:flutter/material.dart';
import 'package:hadeer/Screens/RestP.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

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
            // Logo Image (64 1)
            Positioned(
              width: 360,
              height: 202,
              left: (MediaQuery.of(context).size.width / 2) - 189, // calc(50% - 360px/2 - 9px)
              top: 59,
              child: Image.asset('assets/64.png', fit: BoxFit.contain),
            ),

            // Back Button (Arrow 8.png)
            Positioned(
              left: 43,
              top: 59,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // الرجوع للخلف
                child: Image.asset('assets/8.png', width: 50, height: 50),
              ),
            ),

            // Main Green Card (Rectangle 15)
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
                    stops: [0.0, 0.7356, 0.8606, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(70),
                ),
              ),
            ),

            // Forget Password Title
            Positioned(
              width: 378,
              height: 80,
              left: 20,
              top: 221,
              child: const Text(
                "Forget Password",
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

            // Inner Border Box (Rectangle 20)
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
                    colors: [
                      Color(0xFFD9D9D9),
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                      Color(0xFFD9D9D9),
                    ],
                    stops: [0.0, 0.4375, 0.9279, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4),
                  ],
                ),
                child: Center(
                  child: Image.asset('assets/19.png', width: 80, height: 80), // القفل
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
                "Please Enter your Email Address to Rest Your Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),

            // Email Label
            Positioned(
              width: 137.76,
              height: 27.1,
              left: 91,
              top: 572,
              child: const Text(
                "Email :",
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),

            // Email Input Field (Rectangle 16)
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
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
            ),

            // Send Code Button Background (Rectangle 18)
            Positioned(
              width: 165,
              height: 37,
              left: 138,
              top: 703,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RestPassword()),
                  );
                },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
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
                  boxShadow: const [
                    BoxShadow(color: Color(0x40000000), offset: Offset(0, 4), blurRadius: 4),
                  ],
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            ),
            // Send Code Button Text
            Positioned(
              width: 236,
              height: 80,
              left: 102,
              top: 682,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RestPassword()),
                  );
                },
              child: Center(
                child: Text(
                  "Send Code",
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: const Color(0xFF005D52),
                    shadows: [
                      Shadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 4),
                    ],
                  ),
                ),
              ),
            ),
            )],
        ),
      ),
    );
  }
}