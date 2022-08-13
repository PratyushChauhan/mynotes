import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          controller: _email,
          decoration: const InputDecoration(hintText: "Enter Email:"),
        ),
        TextField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          controller: _password,
          decoration: const InputDecoration(hintText: "Enter Password:"),
        ),
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            //Exception handling
            try {
              final userCred = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: email, password: password);
              print(userCred);
            } on FirebaseAuthException catch (e) {
              //catching authenticaiton errors
              if (e.code == "weak-password") {
                print("Weak password.");
              } else if (e.code == "email-already-in-use") {
                print('Email is already in use.');
              } else if (e.code == "invalid-email") {
                print("Email is invalid.");
              }
            }
          },
          child: const Text("Register"),
        ),
      ],
    );
  }
}
