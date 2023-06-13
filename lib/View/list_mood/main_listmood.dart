import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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

class MyListPage extends StatefulWidget {
  const MyListPage({super.key, required this.title});

  final String title;

  @override
  State<MyListPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyListPage> {

  late List<EmotionData> _charData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState(){
    _charData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myAppBar =  AppBar(
      shadowColor: Color(0),
      backgroundColor: Colors.white,
      leading: Container(
        padding: EdgeInsets.only(left: 30),

        child: OutlinedButton(
            onPressed: () {},
            child: Icon(Icons.arrow_left,size: 40)),
      ),
      leadingWidth: 100,
      title: Container(
        child: Center(
          child:
          OutlinedButton(
            onPressed: () {},
            child: Text(
              "Apr 2023",
              textAlign: TextAlign.justify,
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
              child: Icon(Icons.arrow_right,size: 40,)),
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

        body: ListView(
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
                          onPressed: () {},
                          child: Text("Rekam Moodmu")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return DetailsMood();
                                },)
                            );
                          },
                          child: Text("Lihat Semua")),
                    ],
                  ),
                  Divider(height: 5,color: Colors.black),
                  Card(
                    child: Container(
                      height: bodyHeight * 0.3,
                      width: MediaQueryWidth ,
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
                                  Text("Baik",style: TextStyle(fontSize: 25)),
                                  Text("08 Sab",style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),

                          ),
                          Container(
                            height: bodyHeight,
                            width: MediaQueryWidth * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text("Catatan :"),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                      "Perasaan lelah itu pasti selalu ada, "
                                          "namun rasa itu pasti perlahan akan "
                                          "menghilang seiring dari kekuatan dan "
                                          "niat manusia untuk kembali berjuang demi "
                                          "kehidupan di masa mendatang.",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: bodyHeight,
                            width: MediaQueryWidth * 0.2,
                            child : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child:
                                  ElevatedButton(onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            title: ListTile(
                                              title: Text("Sabtu, 08 April 2023"),
                                              subtitle: Text("Baik"),
                                              leading: Icon(Icons.emoji_emotions),
                                            ),
                                            content: SizedBox(
                                              child: Card(
                                                child: Text(
                                                  "Perasaan lelah itu pasti selalu ada, "
                                                      "namun rasa itu pasti perlahan akan "
                                                      "menghilang seiring dari kekuatan dan "
                                                      "niat manusia untuk kembali berjuang demi "
                                                      "kehidupan di masa mendatang.",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(onPressed: (){
                                                Navigator.of(context).pop();
                                              }, child: Text("Oke"))
                                            ],
                                          );
                                        }
                                    );
                                  }, child: Icon(Icons.fullscreen,),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(MediaQueryWidth * 0.1, bodyHeight * 0.1),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child:
                                  ElevatedButton(onPressed: () {}, child: Icon(Icons.edit),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(MediaQueryWidth * 0.1, bodyHeight * 0.1),
                                    ),
                                  ),
                                ),
                                Container(
                                  child:
                                  ElevatedButton(onPressed: () {
                                      child: showDialog(
                                          context: context,
                                          builder: (context){
                                            return AlertDialog(
                                              title: Text("Confirm"),
                                              content: Text("Apakah anda yakin untuk menghapus mood hari ini ? "),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                }, child: Text("Batal")),
                                                TextButton(onPressed: (){
                                                  Navigator.of(context).pop();
                                                }, child: Text("Oke")),
                                              ],
                                            );
                                          }
                                      );
                                    
                                  }, child: Icon(Icons.delete),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(MediaQueryWidth * 0.1, bodyHeight * 0.1),
                                    ),
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

            SfCartesianChart(
              title: ChartTitle(text: "Bar Chart MOOD",
                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                BarSeries<EmotionData, String>(

                  name: 'MOOD',
                  enableTooltip: true,
                  dataLabelSettings: DataLabelSettings(isVisible: true,color: Colors.blue),
                    dataSource: _charData, xValueMapper: (EmotionData ED, _)=>ED.jns,
                    yValueMapper: (EmotionData ED, _)=>ED.jml),
                
              ],
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: "April 2023",
                    textStyle: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}