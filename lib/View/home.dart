import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tubes_clo2_kelompok4/View/zikir.dart';
import 'inform_home.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'note.dart';

import 'list_mood/main_listmood.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late String? userEmail;
  late String? nama;

  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();

  CollectionReference moodCollection =
  FirebaseFirestore.instance.collection('note');

  CollectionReference user =
  FirebaseFirestore.instance.collection('users');

  Future<String?> getEmailFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  void initState(){
    super.initState();
    _videoPlayerController = VideoPlayerController.asset('assets/video/happy.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: true,
      autoInitialize: true
    );
    getEmailFromSharedPreferences().then((email) {
      setState(() {
        userEmail = email;
      });
    });
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
    //     .collection('users')
    //     .where('email', isEqualTo: userEmail)
    //     .get();
    // // Mendapatkan data dokumen pertama
    // Map<String, dynamic> documentSnapshot = snapshot.docs.first.data();
    // nama = documentSnapshot["username"];
    // String nonNullableString = nama ?? "loading...";

  }
  // Future<String> getNama()async{
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
  //       .collection('users')
  //       .where('email', isEqualTo: userEmail)
  //       .get();
  //   // Mendapatkan data dokumen pertama
  //   Map<String, dynamic> documentSnapshot = snapshot.docs.first.data();
  //   String savedPassword = documentSnapshot ['username'];
  //   return savedPassword;
  // }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  // DateTime today = DateTime.now();
  final List<ChartData> chartData = [
    ChartData('Sangat baik', 25),
    ChartData('baik', 38),
    ChartData('buruk', 34),
    ChartData('Sangat buruk', 52)
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:
        ListView(
          children: [
            //my appbar
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Row(
                children: [
                  Text(
                    "My",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " Homepage",
                    style: TextStyle(fontSize: 28),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),

            //=====================================CARD=============================================
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Container(
                // padding: ,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 25,
                  top: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromARGB(255, 198, 247, 219),
                      Color.fromARGB(255, 153, 191, 251)
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //  cute foto
                    Image.asset(
                      'assets/images/dokter3.1.png',
                      height: 150,
                      width: 130,
                    ),

                    SizedBox(
                      height: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome,",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700, fontSize: 28),
                                  ),
                                    // Text(nonNullableString),
                                ],
                              )),
                          const Text("Checked your mental!"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15,),
              child: Divider(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 15, bottom: 5),
              child: Text("ringkasan"),
            ),
            //============================== Emoji=============================

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              //list tile
              child: PhysicalModel(
                color: const Color.fromARGB(255, 118, 175, 255),
                elevation: 10,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const sangatbaik()),
                    );
                  },
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  //leading
                  leading: Container(
                    padding: const EdgeInsets.only(right: 12.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24),
                      ),
                    ),
                    child: const Text(
                      '🤩',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  //title
                  title: const Text(
                    "pengenalan emosi",
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 37, 93),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //trailing
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Color.fromARGB(255, 35, 37, 93),
                    size: 30.0,
                  ),
                ),
              ),
            ),
            //=======================================to note===============================================

            const SizedBox(
              height: 10,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 25, right: 15, bottom: 5),
              child: Text("catatan"),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              //list tile
              child: PhysicalModel(
                color: const Color.fromARGB(255, 118, 175, 255),
                elevation: 10,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Note()),
                    );
                  },
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  //leading
                  leading: Container(
                    padding: const EdgeInsets.only(right: 12.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24),
                      ),
                    ),
                    child: const Icon(
                        Icons.note,
                      size: 35,
                    )
                  ),
                  //title
                  title: const Text(
                    "catatan harian",
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 37, 93),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //trailing
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Color.fromARGB(255, 35, 37, 93),
                    size: 30.0,
                  ),
                ),
              ),
            ),

            //=========================================zikir==============================================
            const SizedBox(
              height: 10,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 25, right: 15, bottom: 5),
              child: Text("zikir"),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              //list tile
              child: PhysicalModel(
                color: const Color.fromARGB(255, 118, 175, 255),
                elevation: 10,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Zikir()),
                    );
                  },
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  //leading
                  leading: Container(
                      padding: const EdgeInsets.only(right: 12.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(width: 1.0, color: Colors.white24),
                        ),
                      ),
                      child: const Icon(
                        Icons.note,
                        size: 35,
                      )
                  ),
                  //title
                  title: const Text(
                    "yuk berzikir agar tentram",
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 37, 93),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //trailing
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Color.fromARGB(255, 35, 37, 93),
                    size: 30.0,
                  ),
                ),
              ),
            ),
            //=======================================TextField=============================================
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 15, bottom: 5),
              child: Text("note"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              //list tile
              child: PhysicalModel(
                color: const Color.fromARGB(255, 118, 175, 255),

                elevation: 10,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(

                    children: [
                      //judul
                      TextField(
                        // maxLines: 10,
                        controller: judul,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          // labelText: 'Catatan',
                          hintText: 'Masukkan judul catatan',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //isi
                      TextField(
                        maxLines: 10,
                        controller: isi,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          // labelText: 'Catatan',
                          hintText: 'Masukkan isi catatan',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                              // Color(0xFFe0e0e0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 200,
                        height: 45,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF66BB6A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async{
                            String? email = await getEmailFromSharedPreferences();
                            String FieldJudul = judul.text;
                            String FieldIsi = isi.text;

                            if (FieldJudul.isEmpty || FieldIsi.isEmpty){
                              // ignore: use_build_context_synchronously
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("AlertDialog Title"),
                                  content: const Text('AlertDialog description'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }else{
                              await moodCollection.add({
                                'email': email,
                                'isi': FieldIsi,
                                'judul': FieldJudul,
                              });
                            }

                          },
                          child: const Text(
                            "simpan",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),





            //=======================================video=================================================
            const SizedBox(
              height: 10,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 25, right: 15, bottom: 5),
              child: Text("video untukmu"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 118, 175, 255),
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),

            //========================================chart year ===========================================================
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(255, 118, 175, 255),
                ),
                child: SfCircularChart(
                  title: ChartTitle(
                    text: "Total Moods per 2023",
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 35, 37, 93),
                      fontSize: 13,
                    ),
                  ),
                  legend: Legend(
                    isVisible: true,
                  ),
                  series: [
                    // Renders doughnut chart
                    PieSeries<ChartData, String>(
                      // enableTooltip: true,
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      radius: '50%',
                      dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelPosition: ChartDataLabelPosition.outside,
                          useSeriesColor: true),
                    )
                  ],
                ),
              ),
            ),
            //  =============================================== Today ====================================================
            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color.fromARGB(255, 118, 175, 255),
                ),
                child: const Column(
                  children: [
                    Text("today's total mood",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 19)),
                    Divider(),
                    ListTile(
                      leading: Text(
                        '🤩',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      title: Text(
                        'Sangat Baik',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: Text("15",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Text(
                        '🙂',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      title: Text('Baik',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: Text("3",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Text(
                        '😐',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      title: Text('Biasa',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: Text("10",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Text(
                        '😑',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      title: Text('Buruk',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: Text("7",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Text(
                        '😡',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      title: Text('Sangat Buruk',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: Text("7",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    // Divider(),
                  ],
                ),
              ),
            ),
            //  ============================== selesai ==================================
            const SizedBox(height: 15,)
          ],
        )
      ),
    );
  }
}
@override
Widget build(BuildContext context) {
  return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.black,
          items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'List Mood',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
      ]),
      tabBuilder: (context,index){
        switch (index){
          case 0:
            return CupertinoTabView(
              builder: (context){
                return const CupertinoPageScaffold(child: MyHomePage(title: '',));
              },
            );
          // case 1:
          //   return CupertinoTabView(
          //     builder: (context){
          //       return CupertinoPageScaffold(child: child);
          //     },
          //   );
        }
        return Container();
      },
  );
}


class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
// final Color  color;
}
