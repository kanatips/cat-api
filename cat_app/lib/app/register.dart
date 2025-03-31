import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}
class _RegisState extends State<Regis> {
  TextEditingController usercon = TextEditingController();
  TextEditingController passcon = TextEditingController();
  TextEditingController repasscon = TextEditingController();
  TextEditingController username = TextEditingController();

//   Future<bool> registerWithEmail(
//     {required email, required password, required repassword,required username}) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   return _auth
//       .createUserWithEmailAndPassword(email: email, password: password)
//       .then((data) {
//            _firestore.collection('users').doc(data.user!.uid).set({
//           'uid': data.user!.uid,
//           'email': email,
//           'username' :username,
        
//         });
//     return true;
//   }).catchError((e) {
//     return false;
//   });
// }
Future<bool> registerWithEmail({
  required String email,
  required String password,
  required String repassword,
  required String username,
}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  try {
    UserCredential data = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore.collection('users').doc(data.user!.uid).set({
      'uid': data.user!.uid,
      'email': email,
      'username': username,
    });

    // print("Registration Successful!");
    return true;
  } catch (e) {
    // print("Error: $e");
    return false;
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("register"),),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(helperText: "Email"),
            controller: usercon,
          ),
          TextFormField(
            decoration: InputDecoration(helperText: "User Name"),
            controller: username,
          ),
          TextFormField(
            decoration: InputDecoration(helperText: "password"),
            controller: passcon,
          ),
           TextFormField(
            decoration: InputDecoration(helperText: "repassword"),
            controller: repasscon,
          ),
          ElevatedButton
          (onPressed: (){
            registerWithEmail(email: usercon.text, password: passcon.text, repassword: repasscon.text,username: username.text);
          }, 
          child: Text("submit"))
        ],
      ),

    );
  }
}