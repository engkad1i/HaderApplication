import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hadeer/Screens/login.dart';
import 'package:hadeer/Student/Dashboard_s.dart';
import 'package:hadeer/Instructor/Dashboard_i.dart';
import 'package:hadeer/Admin/Dashboard_A.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // إذا كان مسجل دخول، ابدأ فحص الرتبة في الخلفية
        if (snapshot.hasData && snapshot.data != null) {
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('Users')
                .doc(snapshot.data!.uid)
                .get(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(body: Center(child: CircularProgressIndicator()));
              }

              if (userSnapshot.hasData && userSnapshot.data!.exists) {
                String role = userSnapshot.data!.get('Role');

                // التوجيه التلقائي بناءً على الرتبة
                if (role == 'Student') return Dashboard_s ();
                if (role == 'Admin') return AdminDashboard();
                if (role == 'Instructor') return InsturctorDashboard();
                return Dashboard_s();
              }
              // في حال وجود جلسة دخول ولكن لا توجد بيانات في Firestore
              return LoginPage();
            },
          );
        }

        // إذا لم يسجل دخول (الاحتمال الافتراضي)
        return LoginPage();
      },
    );
  }
}