import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tubes_clo2_kelompok4/View/settings/main_settings.dart';

import 'form_datepicker/main_formdatepicker.dart';
import 'home.dart';
import 'list_mood/main_listmood.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
          activeColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'Rekam Moodmu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'List Mood',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ]),
      tabBuilder: (context,index){
        switch (index){
          case 0:
            return CupertinoTabView(
              builder: (context){
                return CupertinoPageScaffold(child: MyHomePage(title: '',));
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context){
                return CupertinoPageScaffold(child: Myformpage(title: '',));
              },
            );
        case 2:
          return CupertinoTabView(
            builder: (context){
              return CupertinoPageScaffold(child: MyListPage(title: '',));
            },
          );
          case 3:
            return CupertinoTabView(
              builder: (context){
                return CupertinoPageScaffold(child: SettingsPageView());
              },
            );
        }
        return Container();
      },
    );

  }
}
