import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hadeer/Screens/login.dart';
// تأكد أن هذا الملف يحتوي على تصميم الصفحة الأولى التي حولناها من CSS
import 'screens/splash_screen.dart';
import 'package:hadeer/Screens/Auter_Wapper.dart';
import 'package:hadeer/Admin/Dashboard_A.dart';
import 'package:hadeer/Student/Dashboard_s.dart';
import 'package:hadeer/Instructor/Dashboard_i.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // تأكد من تهيئة Firebase بشكل صحيح
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // لإخفاء شريط التصحيح
      title: 'Hader Application',
      theme: ThemeData(
        // تم إصلاح الخطأ هنا (إزالة النقطة الزائدة قبل fromSeed)
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF005D52)),
        useMaterial3: true,
      ),
      // قمنا بتغيير الـ home ليكون الصفحة الأولى من تصميمك بدلاً من Placeholder
      home: const HaderApp (),
    );
  }
}

// دالة الانتقال الموحدة التي طلبتها (Linear - 3 Seconds)
// ضع هذه الدالة في ملف مستقل أو في أسفل المين لاستخدامها في التنقل
Route createSmartRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(seconds: 3), // المدة 3 ثوانٍ
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.linear, // حركة خطية
        ),
        child: child,
      );
    },
  );
}

