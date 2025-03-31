import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

 

class _HomeState extends State<Home> {
  List<String> image =[];
  String? userName;
   @override
  void initState() {
    super.initState();
    getcat();
    getUserName();
  }
  Future<void> getcat() async {
  final dio = Dio();

  try {
    final res = await dio.get('https://api.thecatapi.com/v1/images/search?limit=10');
    List<String> images = (res.data as List)
        .map((cat) => cat['url'].toString()) // แปลง url to string
        .toList();
      setState(() {
        image=images;
      });
  } catch (e) { 
  }
}
  Future<void> getUserName() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      DocumentSnapshot userDoc = await firestore.collection('users').doc(uid).get();
        setState(() {
          userName = userDoc['username']; 
        });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("welcome $userName "),
        ),
        body: ListView.builder(
          itemCount: image.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:EdgeInsets.all(5.0)
              ,child: Image.network("${image[index]}"
              ,height: 200,
              fit: BoxFit.cover,), 
              );
          },),
      ),
    );
  }
}