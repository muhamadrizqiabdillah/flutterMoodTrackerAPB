import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/globalColors.dart';
import 'loginView.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future<void> _saveDataToFirebase(BuildContext context) async {
    String username = userController.text;
    String email = emailController.text;
    String password = passController.text;
    String nama = nameController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty || nama.isEmpty) {
      // Validasi jika ada field yang kosong
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

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(email).get();
      if (snapshot.exists) {
        // Validasi jika email sudah terdaftar
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Email is already registered.'),
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

      await firestore.collection('users').doc(email).set({
        'username': username,
        'email': email,
        'password': password,
        'nama': nama,
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return LoginView();
        }),
      );
    } catch (e) {
      print(e.toString());
    }
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
                  "Welcome,",
                  style: TextStyle(
                    color: GlobalColors.textMainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Please create your account",
                  style: TextStyle(
                    color: GlobalColors.textColorBlck,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 18),
                // Username input
                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(height: 18),
                // Email input
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                  ),
                ),
                const SizedBox(height: 12),
                // Nama input
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Nama',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {
                    _saveDataToFirebase(context);
                  },
                  child: Text('Sign Up'),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member? "),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return LoginView();
                          }),
                        );
                      },
                      child: Text(
                        "Log In",
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
