import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_instance.dart';

class createScreen extends StatefulWidget {
  const createScreen({Key? key}) : super(key: key);

  @override
  State<createScreen> createState() => _createScreenState();
}

class _createScreenState extends State<createScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController jumlahController = TextEditingController();

  @override
  void initState() {
    super.initState();
    databaseInstance.database();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create zikir'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('zikir'),
            TextField(
              controller: jumlahController,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                await databaseInstance.database(); // Initialize the database
                await databaseInstance.insert({
                  'email': await getEmailFromSharedPreferences(),
                  'jumlah': jumlahController.text,
                });
                Navigator.pop(context);
              },
              child: Text('submit'),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> getEmailFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
}
