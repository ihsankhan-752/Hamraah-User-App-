import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:user_app/splash_screen/splash_screen.dart';

import '../global/globals.dart';
import '../widgets/custom_msg.dart';
import '../widgets/progress_dialog.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  validateForm() {
    if (nameController.text.length < 3) {
      showCustomMsg(context, "Name Must Be Greater Than 3 Characters");
    } else if (!emailController.text.contains("@")) {
      showCustomMsg(context, "Email is Not Valid");
    } else if (phoneController.text.isEmpty) {
      showCustomMsg(context, "Provide phone Number");
    } else if (passwordController.text.length < 6) {
      showCustomMsg(context, "Password will be at least 6 characters");
    } else {
      saveUserInformation();
    }
  }

  saveUserInformation() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return ProgressDialog(message: "Processing Please Wait");
        });

    final user = await fAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).catchError((e) {
      Navigator.pop(context);
      showCustomMsg(context, e.toString());
    });
    if (user.user != null) {
      Map userMap = {
        "id": user.user!.uid,
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
      };
      DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");
      userRef.child(fAuth.currentUser!.uid).set(userMap);
      currentFirebaseUser = user.user;
      showCustomMsg(context, "User Account is Successfully Created");
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => MySplashScreen()));
    } else {
      Navigator.pop(context);
      showCustomMsg(context, "Account is Not Created Yet!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset("images/logo.png"),
              ),
              SizedBox(height: 10),
              Text(
                "Register as a User",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: nameController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "name",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  hintText: "name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "email",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  hintText: "email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "password",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  hintText: "password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration: InputDecoration(
                  labelText: "phone",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  hintText: "phone",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  onPressed: () {
                    validateForm();
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Text("Already have an Account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
