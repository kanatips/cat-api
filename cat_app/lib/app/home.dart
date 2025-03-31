
import 'package:cat_app/app/login.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Edit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> image =[];
  String userName="";
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

  Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Login()));
  
}

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>EditUser())).then((_) => getUserName());
                },
                child: Icon(Icons.person)),
              Text("welcome $userName "),
              InkWell(child: Icon(Icons.logout)
              ,onTap: () {
                logout();
                setState(() { 
                });
              },)
            ],
          ),


        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: image.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:EdgeInsets.all(5.0)
                    ,child: Image.network("${image[index]}"
                    ,height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if(loadingProgress ==null) return child;
                       return Center(child: CircularProgressIndicator());
                        
                    },
                    ), 
                    );
                },
              
                ),
            ),
              // ElevatedButton(onPressed: (){getcat();}, child: Text("add"))
          ],
        ),
      
      ),

    );
  }
}