
import 'package:cat_app/app/home.dart';
import 'package:cat_app/app/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// ดึงค่า UID จาก SharedPreferences
Future<String?> getUserUid() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('uid');
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
     
//       home: Login(),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: getUserUid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator())); 
          } else {
            return snapshot.hasData ? Home() : Login(); // ถ้ามี UID ไป Home ถ้าไม่มีไป Login
          }
        },
      ),
    );
  }
}

