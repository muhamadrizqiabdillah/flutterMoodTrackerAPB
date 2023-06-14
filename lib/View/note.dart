import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

Future<String?> getEmailFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

CollectionReference getCollection() {
  FirebaseFirestore myDB = FirebaseFirestore.instance;
  CollectionReference users = myDB.collection("note");
  return users;
}

class _NoteState extends State<Note> {
  late String? userEmail;

  @override
  void initState() {
    super.initState();
    getEmailFromSharedPreferences().then((email) {
      setState(() {
        userEmail = email;
      });
    });
  }
  void deleteData(String documentId) {
    getCollection()
        .doc(documentId)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil dihapus.'),
        ),
      );
    })
        .catchError((error) {
      print("Failed to delete user: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menghapus data.'),
        ),
      );
    });
  }
  void updateData(String documentId, String judul, String isi) {
    getCollection()
        .doc(documentId)
        .update({
      "judul": judul,
      "isi": isi,
    })
        .then((value) {
      Navigator.pop(context);
    })
        .catchError((error) {
      print("Failed to update user: $error");
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Daftar Catatan"),
      ),
      body: userEmail != null ? StreamBuilder(stream: getCollection().where('email', isEqualTo: userEmail).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var dataIndex = snapshot.data!.docs[index];
                return ListTile(
                  leading: IconButton(
                    onPressed: () {
                      deleteData(
                        dataIndex.id,
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController controllerTFNama =
                          TextEditingController(
                              text: dataIndex['judul']);
                          TextEditingController controllerTFKota =
                          TextEditingController(
                              text: dataIndex['isi']);
                          return AlertDialog(
                            title: const Text('Ubah Data'),
                            content: SizedBox(
                              height: 150,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: controllerTFNama,
                                  ),
                                  TextField(
                                    controller: controllerTFKota,
                                    maxLines: 10,
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Simpan'),
                                onPressed: () {
                                  updateData(
                                    dataIndex.id,
                                    controllerTFNama.text,
                                    controllerTFKota.text,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  title: Text(
                    "Judul: ${dataIndex['judul']} ",
                  ),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) {
                        TextEditingController controllerTFNama = TextEditingController(text: dataIndex['judul']);
                        TextEditingController controllerTFKota = TextEditingController(text: dataIndex['isi']);
                        return AlertDialog(
                          title: const Text('lihat data'),
                          content: SizedBox(
                            height: 300,
                            child: Column(
                              children: [
                                TextField(
                                  controller: controllerTFNama,

                                ),
                                TextField(
                                  controller: controllerTFKota,
                                  // maxLines: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          }
          return const Text("Data tidak ada");
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
