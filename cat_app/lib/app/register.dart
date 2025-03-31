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
    return true;
  } catch (e) {
    return false;
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("register"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(helperText: "Email"
              ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ),
              controller: usercon,
            ),
            TextFormField(
              decoration: InputDecoration(helperText: "User Name"
              ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ),
              controller: username,
            ),
            TextFormField(
              decoration: InputDecoration(helperText: "password"
              ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ),
              controller: passcon,
            ),
             TextFormField(
              decoration: InputDecoration(helperText: "repassword"
              ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ),
              controller: repasscon,
            ),
            ElevatedButton
            (onPressed: (){
              registerWithEmail(email: usercon.text, password: passcon.text, repassword: repasscon.text,username: username.text);
            }, 
            child: Text("submit"))
          ],
        ),
      ),

    );
  }
}