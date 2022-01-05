import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/views/signin.dart';
import 'package:quizmaker/widgets/widgets.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedin: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: _isLoading
          ? Container(
              child: const Center(
              child: CircularProgressIndicator(),
            ))
          : Form(
              key: _formKey,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(children: [
                  const Spacer(),
                  TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Name" : null;
                      },
                      decoration: const InputDecoration(hintText: "Name"),
                      onChanged: (val) {
                        name = val;
                      }),
                  TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Email ID" : null;
                      },
                      decoration: const InputDecoration(hintText: "Email"),
                      onChanged: (val) {
                        email = val;
                      }),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val!.isEmpty ? "Enter Password" : null;
                      },
                      decoration: const InputDecoration(hintText: "Password"),
                      onChanged: (val) {
                        password = val;
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      signUp();
                    },
                    child: blueButton((context), "Sign Up"),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? ",
                          style: TextStyle(fontSize: 15.5)),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()));
                          },
                          child: const Text("Sign In",
                              style: TextStyle(
                                  fontSize: 15.5,
                                  decoration: TextDecoration.underline))),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ]),
              ),
            ),
    );
  }
}
