import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _AddUserState();
}

class _AddUserState extends State<EditUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController usercon = TextEditingController();
  Future<void> updateUser()async{
    String? uid =_auth.currentUser?.uid;
    String newUsername = usercon.text.trim();
    try{
      await _firestore.collection('users').doc(uid).update(
        {
          'username':newUsername
        }
      );
      Navigator.pop(context);

    }catch(e){
        print(e);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(helperText: "User Name"
              ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ),
              controller: usercon,
            ),
            ElevatedButton
            (onPressed: updateUser, 
            child: Text("submit"))
            ,ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("cancel"))
          ],
        ),
      ),
    );
  }
}