import 'package:cat_app/app/register.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

Future<bool> signInWithEmail(BuildContext context,
    {required String email, required String password}) {
      final FirebaseAuth _auth = FirebaseAuth.instance;
  return _auth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((result) {
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>Home()));
    return true;
  }).catchError((e) {
    print(e);
    switch (e.code) {
      case "ERROR_WRONG_PASSWORD":
        // print("Wrong Password! Try again.");
        break;
      case "ERROR_INVALID_EMAIL":
        // print("Email is not correct!, Try again");
        break;
      case "ERROR_USER_NOT_FOUND":
        // print("User not found! Register first!");
        break;
      case "ERROR_USER_DISABLED":
        // print("User has been disabled!, Try again");
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        // print(
            // "Sign in disabled due to too many requests from this user!, Try again");
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        // print(
        //     "Operation not allowed!, Please enable it in the firebase console");
        break;
      default:
        // print("Unknown error");
    }
    return false;
  });
}
class _LoginState extends State<Login> {
  TextEditingController usercon = TextEditingController();
  TextEditingController passcon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          children: [
            TextFormField(
              controller: usercon,
              decoration: InputDecoration(counterText: "email"
              ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ),
            ),
            SizedBox(height: 20,),
             TextFormField(
              controller: passcon,
              decoration: InputDecoration(counterText: "password"
              ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)) ),
            ),
            ElevatedButton(onPressed: (){
              signInWithEmail(context, email: usercon.text, password: passcon.text);
            }, child: Text("Login")),
            ElevatedButton(
            onPressed: (){
              passcon.clear();
              Navigator.push(context
              , MaterialPageRoute(builder: (_)=>Regis()));
            }, 
            child: Text("Register")),
          ],
        ),
      ),
    );
  }
}