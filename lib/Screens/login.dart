import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// استيراد الصفحات
import 'package:hadeer/Admin/Dashboard_A.dart';
import 'package:hadeer/Instructor/Dashboard_i.dart';
import 'package:hadeer/Screens/CreateAccount.dart';
import 'package:hadeer/Screens/ForgetP.dart';
import 'package:hadeer/Student/Dashboard_s.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) return;
    setState(() => isLoading = true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        String role = userDoc.get('Role').toString().trim().toLowerCase();
        if (!mounted) return;
        if (role == 'admin') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AdminDashboard()));
        }
        else if (role == 'instructor') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => InsturctorDashboard()));
        }

      else if (role == 'student') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard_s()));
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("خطأ: ${e.toString()}")));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
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
            colors: [Color(0xFFD9D9D9), Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFD9D9D9)],
          ),
        ),
        child: Stack(
          children: [
            // الشعار
            Positioned(
              left: (screenWidth / 2) - 180,
              top: 59,
              child: Image.asset('assets/64.png', width: 360, height: 202),
            ),

            // المستطيل الأخضر
            Positioned(
              left: 17, top: 184,
              child: Container(
                width: 395, height: 675,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  gradient: const LinearGradient(colors: [Color(0xFF29776E), Color(0xFF005D52)]),
                ),
              ),
            ),

            // Welcome
            const Positioned(
              left: 22, top: 261, width: 378,
              child: Text('Welcome !', textAlign: TextAlign.center, style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
            ),

            // إطار الحقول
            Positioned(
              left: 62, top: 405,
              child: Container(
                width: 304, height: 394,
                decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 3), borderRadius: BorderRadius.circular(30)),
              ),
            ),

            // الإيميل
            Positioned(left: 82, top: 495, child: _buildInput("Email :", emailController, false)),

            // الباسورد
            Positioned(left: 79, top: 599, child: _buildInput("Password :", passwordController, true)),

            // --- زر Forget Password (تمت إضافته هنا) ---
            Positioned(
              left: 230, // حسب إحداثيات الـ CSS ليظهر جهة اليمين
              top: 665,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPassword(),
                    ),
                  );


                },
                child: const Text(
                  'Forget Password ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white, // هذا السطر يجعل الأندرلاين أبيض
                    decorationThickness: 1.5,      // اختياري: للتحكم بسمك الخط
                    fontFamily: 'Tajawal',
                  ),
                ),
                ),
            ),

            // زر LOGIN
            Positioned(
              left: 138, top: 703,
              child: GestureDetector(
                onTap: isLoading ? null : login,
                child: Container(
                  width: 165, height: 37,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('LOGIN', style: TextStyle(color: Color(0xFF005D52), fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),

            // Create Account
            Positioned(
              left: 115,
              top: 747,
              width: 211,
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Haven’t Account ? ',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    TextSpan(
                      text: 'Create Account',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        decoration: TextDecoration.underline, // إضافة الخط
                        decorationColor: Colors.white,         // لون الخط أبيض
                        decorationThickness: 1.5,             // سمك الخط
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                                MaterialPageRoute(
                              builder: (context) => const CreateAccountScreen(),
                            ),
                          );
                        },

                      // اختيارياً: يمكنك إضافة GestureDetector هنا لجعل الكلمة قابلة للضغط
                      // recognizer: TapGestureRecognizer()..onTap = () => print('Go to Register'),
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

  Widget _buildInput(String label, TextEditingController controller, bool isPass) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 5),
        Container(
          width: 265, height: 37,
          decoration: BoxDecoration(color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(40)),
          child: TextField(
            controller: controller,
            obscureText: isPass,
            decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10)),
          ),
        ),
      ],
    );
  }
}