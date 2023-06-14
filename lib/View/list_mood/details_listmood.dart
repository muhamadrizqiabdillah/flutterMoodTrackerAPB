import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Data/shared_prefs.dart';
import '../../constants/app_const.dart';


class DetailsMood extends StatefulWidget {
  const DetailsMood({Key? key}) : super(key: key);

  @override
  State<DetailsMood> createState() => _DetailsMoodState();
}

class _DetailsMoodState extends State<DetailsMood> {
  Stream<QuerySnapshot> getCollection(){
    FirebaseFirestore myDB = FirebaseFirestore.instance;
    return myDB.collection("mood").where("email", isEqualTo: emailValue).snapshots();
  }
  String? emailValue;

  @override
  void initState() {
    super.initState();
    loadValue();
  }
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
        body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: getCollection(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data!.docs.length, // Jumlah elemen dalam daftar
                itemBuilder: (BuildContext context, int index) {
                  var dataIndex = snapshot.data!.docs[index];
                  return Card(
                    margin: EdgeInsets.only(top: 30),
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
                                    "${dataIndex['description']}",
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: ListTile(
                                              title: Text("${dataIndex['date']}"),
                                              subtitle: Text("Baik"),
                                              leading: Text("${dataIndex['mood']}"),
                                            ),
                                            content: SizedBox(
                                              child: Card(
                                                child: Text(
                                                  "${dataIndex['description']}",
                                                  maxLines: 4,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Tutup"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text("Lihat Detail"),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text("Ubah"),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(context: context, builder:(context) {
                                      return AlertDialog(
                                        title: const Text('Hapus Data'),
                                        content: const Text('Apakah Anda yakin ingin menghapus data ini ?'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: const Text('batal') ),
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
                                            child: const Text("Hapus"),
                                          ),

                                        ],
                                      );
                                    },
                                    );
                                  },
                                  child: Text("Hapus"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }else if (snapshot.hasError) {
              return Text('Terjadi kesalahan saat mengambil data.');
            }else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
  void loadValue() async {
    emailValue = await SharedPrefs.getString(strKeyE);
    setState(() {});
  }
}

