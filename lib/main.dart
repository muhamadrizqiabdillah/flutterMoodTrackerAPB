import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'View/registerView.dart';
import 'package:tubes_clo2_kelompok4/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tubes_clo2_kelompok4/View/Control.dart';
import 'package:tubes_clo2_kelompok4/Data/shared_prefs.dart';
import 'package:tubes_clo2_kelompok4/constants/app_const.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
    ),
    // DeviceOrientation.portraitUp,
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String?> isLogin;

  @override
  void initState() {
    super.initState();
    isLogin = SharedPrefs.getString(strKeyE);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: isLogin,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator if the future is still loading
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // User is logged in
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: MainScreen(),
            );
          } else {
            // User is not logged in
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: RegisterView(),
            );
          }
        }
      },
    );
  }
}
