import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes_clo2_kelompok4/View/registerView.dart';
import 'package:tubes_clo2_kelompok4/View/widgets/btnFormGlobal.dart';
import 'package:tubes_clo2_kelompok4/View/widgets/txtFormGlobal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/globalColors.dart';
import 'Control.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    String email = userController.text;
    String password = passController.text;

    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Account does not exist'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    Map<String, dynamic> userData = snapshot.docs.first.data();
    String savedPassword = userData['password'];

    if (savedPassword != password) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid email or password.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    // Login berhasil
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'email', email); // Menyimpan email ke SharedPreferences

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return MainScreen();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 40,
              top: 20,
              right: 40,
              bottom: 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "LOGO",
                    style: TextStyle(
                      color: GlobalColors.textMainColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  "Hi There!,",
                  style: TextStyle(
                    color: GlobalColors.textMainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please login with your account",
                  style: TextStyle(
                    color: GlobalColors.textColorBlck,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 18),
                // Email input
                TxtFormGlobal(
                  controller: userController,
                  placeHolder: 'Your Email',
                  textInputType: TextInputType.emailAddress,
                  obscure: false,
                ),
                const SizedBox(height: 12),
                TxtFormGlobal(
                  controller: passController,
                  placeHolder: 'Your Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {
                    _login(context);
                  },
                  child: Text('Log In'),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return RegisterView();
                          }),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: GlobalColors.textMainColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
