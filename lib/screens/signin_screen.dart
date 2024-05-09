

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodle/reusable_widgets/reusable_widgets.dart';
import 'package:moodle/screens/home_screen.dart';
import 'package:moodle/screens/signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.pinkAccent, 
    Colors.blue, Colors.purple], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    child: SingleChildScrollView(
      child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.2, 20, 0),
      child: Column(children: <Widget>[
        const Text(
            "Moodle Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 20,),reusableTextField("Enter email", Icons.person_outline, false, _email),
      const SizedBox(height: 20,), 
      reusableTextField("Enter Password", Icons.lock_outline, true, _pass),
      const SizedBox(height: 20,),
      firebaseUIButton(context, "Sign In", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _email.text,
                          password: _pass.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption(),
      const SizedBox(
        height: 20,
      ),


      ],),),
    ),
    
    ),);
  }



  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

  