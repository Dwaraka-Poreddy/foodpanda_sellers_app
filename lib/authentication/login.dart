import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  resetTextFields() {
    emailController.clear();
    passwordController.clear();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      loginNow();
    } else {
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: "Please enter Email and Password.",
          );
        },
      );
      loginNow();
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingDialog(message: "Checking Credentials");
        });
    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
      if (currentUser != null) {
        readDataAndSetDataLocally(currentUser!);
      }
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (c) {
          return ErrorDialog(
            message: error.message.toString(),
          );
        },
      );
    });
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!
            .setString("email", snapshot.data()!["sellerEmail"]);
        await sharedPreferences!
            .setString("name", snapshot.data()!["sellerName"]);
        await sharedPreferences!
            .setString("photoUrl", snapshot.data()!["sellerAvatarUrl"]);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (e) {
          return const HomeScreen();
        }));
      } else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        resetTextFields();
        showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message:
                  "Seller records not found. Please check your credentials.",
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: const Image(
                image: AssetImage("images/seller.png"),
                height: 270,
              )),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  hintText: "Email",
                  data: Icons.email,
                  controller: emailController,
                  enabled: true,
                  obscureText: false,
                ),
                CustomTextField(
                  hintText: "Password",
                  data: Icons.lock,
                  controller: passwordController,
                  enabled: true,
                  obscureText: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                formValidation();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all fields.'),
                  ),
                );
              }
            },
            child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
