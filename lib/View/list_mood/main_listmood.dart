import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tubes_clo2_kelompok4/Data/shared_prefs.dart';
import 'package:tubes_clo2_kelompok4/constants/app_const.dart';
import 'details_listmood.dart';

class EmotionData {
  EmotionData(this.jns, this.jml);
  final String jns;
  final double jml;
}

List<EmotionData> getChartData(){
  final List<EmotionData> chartData = [
    EmotionData("Sangat Baik", 5),
    EmotionData("Baik", 8),
    EmotionData("Biasa", 4),
    EmotionData("Buruk", 5),
    EmotionData("Sangat Buruk", 8),

  ];
  return chartData;
}
FirebaseFirestore firestore = FirebaseFirestore.instance;
class MyListPage extends StatefulWidget {
  const MyListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyListPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyListPage> {
  late List<EmotionData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  String? emailValue;

  Stream<QuerySnapshot> getCollection(){
    FirebaseFirestore myDB = FirebaseFirestore.instance;
    return myDB.collection("mood").where("email", isEqualTo: emailValue).snapshots();
  }

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    _loadValue();
  }

  @override
  Widget build(BuildContext context) {
    final myAppBar = AppBar(
      shadowColor: Color(0),
      backgroundColor: Colors.white,
      leading: Container(
        padding: EdgeInsets.only(left: 30),
        child: OutlinedButton(
          onPressed: () {},
          child: Icon(Icons.arrow_left, size: 40),
        ),
      ),
      leadingWidth: 100,
      title: Container(
        child: Center(
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              "Apr 2023",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          child: OutlinedButton(
            onPressed: () {},
            child: Icon(Icons.arrow_right, size: 40),
          ),
          width: 100,
          padding: EdgeInsets.only(right: 30),
        ),
      ],
    );

    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    final bodyHeight = MediaQueryHeight - myAppBar.preferredSize.height - MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar,
        body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: getCollection(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var index = 0;
              var dataIndex = snapshot.data!.docs[index];
              return ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                              },
                              child: Text("Rekam Moodmu $emailValue"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return DetailsMood();
                                  }),
                                );
                              },
                              child: Text("Lihat Semua"),
                            ),
                          ],
                        ),
                        Divider(height: 5, color: Colors.black),
                        Card(
                          child: Container(
                            height: bodyHeight * 0.3,
                            width: MediaQueryWidth,
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Card(
                                  child: Container(
                                    height: bodyHeight,
                                    width: MediaQueryWidth * 0.4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${dataIndex['mood']}", style: TextStyle(fontSize: 25)),
                                        Text("${dataIndex['date']}", style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: bodyHeight,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: Text("Catatan :"),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: SingleChildScrollView(
                                              child: Text(
                                                "${dataIndex['description']}",
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: bodyHeight,
                                  width: MediaQueryWidth * 0.2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: ListTile(
                                                  title: Text("${dataIndex['date']}"),
                                                  subtitle: Text("${dataIndex['mood']}"),
                                                  leading: Icon(Icons.emoji_emotions),
                                                ),
                                                content: SizedBox(
                                                  child: Card(
                                                    child: Text(
                                                      "${dataIndex['description']}",
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text("Oke"),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(Icons.fullscreen),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(MediaQueryWidth * 0.1, bodyHeight * 0.1),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Icon(Icons.edit),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(MediaQueryWidth * 0.1, bodyHeight * 0.1),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Hapus Data'),
                                                content: const Text('Apakah Anda yakin ingin menghapus data ini ?'),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Batal'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      snapshot.data!.docs[index].reference.delete().then((value) {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(
                                                            content: Text('Data berhasil dihapus'),
                                                          ),
                                                        );
                                                      }).catchError((error) {
                                                        print('Gagal menghapus data: $error');
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          const SnackBar(
                                                            content: Text('Gagal menghapus data'),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: const Text('Hapus'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(Icons.delete),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(MediaQueryWidth * 0.1, bodyHeight * 0.1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Bar Chart MOOD",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 300,
                          child: SfCartesianChart(
                            tooltipBehavior: _tooltipBehavior,
                            series: <ChartSeries>[
                              BarSeries<EmotionData, String>(
                                name: 'MOOD',
                                enableTooltip: true,
                                dataLabelSettings: DataLabelSettings(isVisible: true, color: Colors.blue),
                                dataSource: _chartData,
                                xValueMapper: (EmotionData ED, _) => ED.jns,
                                yValueMapper: (EmotionData ED, _) => ED.jml,
                                color: Colors.blue,
                              ),
                            ],
                            primaryXAxis: CategoryAxis(),
                            primaryYAxis: NumericAxis(
                              title: AxisTitle(
                                text: "April 2023",
                                textStyle: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }else if (snapshot.hasError) {
              return Text('Terjadi kesalahan saat mengambil data.');
            }else {
              return CircularProgressIndicator();
            }
          }
        ),
      ),
    );
  }

  void _loadValue() async {
    emailValue = await SharedPrefs.getString(strKeyE);
    setState(() {});
  }
}
