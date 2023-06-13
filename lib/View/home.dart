import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'inform_home.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';

import 'list_mood/main_listmood.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        body: ListView(
          children: [
            //my appbar
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Row(
                children: const [
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
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Welcome,",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 28),
                              ),
                              Text("Nama"),
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
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Divider(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text("summary"),
            ),
            //============================== Emoji=============================

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              //list tile
              child: PhysicalModel(
                color: Color.fromARGB(255, 118, 175, 255),
                elevation: 10,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => sangatbaik()),
                    );
                  },
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  //leading
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
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
                    "Introduction to Emoji",
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
            //========================================chart year ===========================================================
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 118, 175, 255),
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
            SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(255, 118, 175, 255),
                ),
                child: Column(
                  children: const [
                    Text("today's total mood",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 19)),
                    Divider(),
                    ListTile(
                      leading: const Text(
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
                      leading: const Text(
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
                      leading: const Text(
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
                      leading: const Text(
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
                      leading: const Text(
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
            SizedBox(
              height: 15,
            )
          ],
        ),
        // bottomNavigationBar: ConvexAppBar(
        //     items: [
        //       TabItem(icon: Icons.home, title: 'Home'),
        //       TabItem(icon: Icons.map, title: 'Discovery'),
        //       TabItem(icon: Icons.add, title: 'Add'),
        //       TabItem(icon: Icons.message, title: 'Message'),
        //       TabItem(icon: Icons.people, title: 'Profile'),
        //     ],
        //   initialActiveIndex: 2,
        // ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
    tabBuilder: (context, index) {
      switch (index) {
        case 0:
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(
                  child: MyHomePage(
                title: '',
              ));
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
