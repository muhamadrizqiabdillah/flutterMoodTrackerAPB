import 'package:flutter/material.dart';


class SettingsPageView extends StatefulWidget {
  @override
  _SettingsPageViewState createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color.fromRGBO(0, 197, 20, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0),
            Divider(),
            ListTile(
              title: Text('Profile'),
              subtitle: Text('Edit Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                // Edit Profile
              },
            ),
            Divider(),
            ListTile(
              title: Text('Theme colors'),
              subtitle: Text('Change the colors of mood entries'),
              leading: Icon(Icons.color_lens),
              onTap: () {
                // Ganti warna sesuai dengan mood user
              },
            ),
            Divider(),
            ListTile(
              title: Text('Language'),
              subtitle: Text('Change Language in Indonesia or English'),
              leading: Icon(Icons.language),
              onTap: () {
                // Mengganti bahasa sesuai keinginan dan kebutuhan user
              },
            ),
            Divider(),
            ListTile(
              title: Text('Login & SignUp'),
              subtitle: Text('Link to Login SignUp Page'),
              leading: Icon(Icons.login),
              onTap: () {
                // Login dan SignUp
              },
            ),
            Divider(),
            ListTile(
              title: Text('FAQ'),
              subtitle: Text('Frequently Asked Questions/Pertanyaan Umum'),
              leading: Icon(Icons.question_answer),
              onTap: () {
                // Pertanyaan Umum
              },
            ),
            Divider(),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
