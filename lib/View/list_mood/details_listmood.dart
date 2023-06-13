
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsMood extends StatefulWidget {
  const DetailsMood({Key? key}) : super(key: key);

  @override
  State<DetailsMood> createState() => _DetailsMoodState();
}

class _DetailsMoodState extends State<DetailsMood> {
  @override
  Widget build(BuildContext context) {
    final myAppBar = AppBar(
      title: Text("Details - April 2023"),
    );

    final MediaQueryHeight = MediaQuery.of(context).size.height;
    final MediaQueryWidth = MediaQuery.of(context).size.width;
    final bodyHeight = MediaQueryHeight - myAppBar.preferredSize.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar,
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Card(
              margin: EdgeInsets.only(top: 30),
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
            Card(
              margin: EdgeInsets.only(top: 30),
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
            Card(
              margin: EdgeInsets.only(top: 30),
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
            Card(
              margin: EdgeInsets.only(top: 30),
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
    );
  }
}
