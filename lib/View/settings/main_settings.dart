import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Data/shared_prefs.dart';
import '../../constants/app_const.dart';


class SettingsPageView extends StatefulWidget {
  @override
  _SettingsPageViewState createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  File? image;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        image = File(imagePicked.path);
      });
    }
  }

  Future<void> getCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.camera);
    if (imagePicked != null) {
      setState(() {
        image = File(imagePicked.path);
      });
    }
  }

  String? emailValue;
  Stream<QuerySnapshot> getCollection(){
    FirebaseFirestore myDB = FirebaseFirestore.instance;
    return myDB.collection("users").where("email", isEqualTo: emailValue).snapshots();
  }
  @override
  void initState() {
    super.initState();
    loadValue();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color.fromRGBO(0, 197, 20, 1),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: getCollection(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var index = 0;
            var dataIndex = snapshot.data!.docs[index];
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/editProfile');
                    },
                    child: Column(
                      children: <Widget>[
                        Row(children: [
                          TextButton(
                              onPressed: ()async{
                                await getImage();
                              },
                              child: Text('Open Image',
                                style: TextStyle(color: Colors.blue),
                              )
                          ),
                          TextButton(
                              onPressed: ()async{
                                await getCamera();
                              },
                              child: Text('Open Camera',
                                style: TextStyle(color: Colors.blue),
                              )
                          ),
                        ]),
                        CircleAvatar(
                          backgroundImage: image != null ? FileImage(image!) : AssetImage('assets/profile_picture.jpg') as ImageProvider<Object>?,
                          radius: 50.0,
                        ),

                        SizedBox(height: 8.0),
                        Text(
                          // _username ?? 'Loading...',
                          '${dataIndex['username']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Divider(),
                  ListTile(
                    title: Text('Profile'),
                    subtitle: Text('Edit Profile'),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.pushNamed(context, '/editProfile');
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Theme colors'),
                    subtitle: Text('Change the colors of mood entries'),
                    leading: Icon(Icons.color_lens),
                    onTap: () {
                      Navigator.pushNamed(context, '/themeColors');
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Language'),
                    subtitle: Text('Change Language in Indonesia or English'),
                    leading: Icon(Icons.language),
                    onTap: () {
                      Navigator.pushNamed(context, '/language');
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Login & SignUp'),
                    subtitle: Text('Link to Login SignUp Page'),
                    leading: Icon(Icons.login),
                    onTap: () {
                      // Navigator.pushNamed(context, '/loginSignUp');
                      SharedPrefs.remove(strKeyE);
                      SharedPrefs.setString(strKeyE, '');
                      loadValue();
                      Navigator.pop(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('FAQ'),
                    subtitle: Text('Frequently Asked Questions/Pertanyaan Umum'),
                    leading: Icon(Icons.question_answer),
                    onTap: () {
                      Navigator.pushNamed(context, '/faq');
                    },
                  ),
                  Divider(),
                  SizedBox(height: 16.0),
                ],
              ),
            );
          } else if (snapshot.hasError) {
              return Text('Terjadi kesalahan saat mengambil data.');
          }else {
               return CircularProgressIndicator();
          }
        }
      )
    );
  }
  void loadValue() async {
    emailValue = await SharedPrefs.getString(strKeyE);
    setState(() {});
  }
}

// Example page for Edit Profile
class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Text('Edit Profile Page'),
      ),
    );
  }
}

// Example page for Theme Colors
class ThemeColorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Colors'),
      ),
      body: Center(
        child: Text('Theme Colors Page'),
      ),
    );
  }
}

// Example page for Language
class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
      ),
      body: Center(
        child: Text('Language Page'),
      ),
    );
  }
}

// Example page for Login & SignUp
class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login & SignUp'),
      ),
      body: Center(
        child: Text('Login & SignUp Page'),
      ),
    );
  }
}

// Example page for FAQ
class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Center(
        child: Text('FAQ Page'),
      ),
    );
  }
}