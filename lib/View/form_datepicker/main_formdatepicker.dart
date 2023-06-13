import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Myformpage extends StatefulWidget {
  const Myformpage({Key? key, required this.title});

  final String title;

  @override
  State<Myformpage> createState() => _MyformpageState();
}

class _MyformpageState extends State<Myformpage> {
  TextEditingController date = TextEditingController();
  String? selectedNumber;
  TextEditingController description = TextEditingController();

  CollectionReference moodCollection =
      FirebaseFirestore.instance.collection('mood');

  Future<String?> getEmailFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  void _addMarker(LatLng position, String markerId) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _addMarker(
      LatLng(position.latitude, position.longitude),
      'current_location',
    );
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Input Mood Anda"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            children: [
              SizedBox(height: 21),
              Text(
                'Histori Mood Terakhir',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              FutureBuilder<String?>(
                future: getEmailFromSharedPreferences(),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError || snapshot.data == null) {
                    return Text('Terjadi kesalahan. Silakan coba lagi.');
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: moodCollection
                        .where('email', isEqualTo: snapshot.data)
                        .limit(2)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                          return ListTile(
                            title: Text(
                              'Mood: ${data['mood']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tanggal: ${data['date']}'),
                                Text('Catatan: ${data['description']}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                snapshot.data!.docs[index].reference.delete();
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 21),
              TextField(
                readOnly: true,
                controller: date,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  icon: Icon(Icons.calendar_month_rounded),
                  labelText: "Pilih Tanggal",
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.blue,
                            onPrimary: Colors.black,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    date.text = formattedDate;
                  }
                },
              ),
              const SizedBox(
                height: 32,
                width: 32,
              ),
              Container(
                height: 200,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 14,
                  ),
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNumber = '😡';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selectedNumber == '😡'
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '😡',
                        style: TextStyle(
                          fontSize: 32,
                          color: selectedNumber == '😡'
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNumber = '😑';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selectedNumber == '😑'
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '😑',
                        style: TextStyle(
                          fontSize: 32,
                          color: selectedNumber == '😑'
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNumber = '😐';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selectedNumber == '😐'
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '😐',
                        style: TextStyle(
                          fontSize: 32,
                          color: selectedNumber == '😐'
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNumber = '🙂';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selectedNumber == '🙂'
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '🙂',
                        style: TextStyle(
                          fontSize: 32,
                          color: selectedNumber == '🙂'
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNumber = '🤩';
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: selectedNumber == '🤩'
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '🤩',
                        style: TextStyle(
                          fontSize: 32,
                          color: selectedNumber == '🤩'
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: description,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Catatan (opsional)',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  String? email = await getEmailFromSharedPreferences();
                  if (selectedNumber == null) {
                    Fluttertoast.showToast(
                      msg: 'Silakan pilih mood Anda',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  } else if (date.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: 'Silakan pilih tanggal',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  } else if (email != null) {
                    Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high,
                    );
                    LatLng latLng = LatLng(
                      position.latitude,
                      position.longitude,
                    );
                    _addMarker(latLng, 'Current Location');
                    _mapController!.animateCamera(
                      CameraUpdate.newLatLngZoom(latLng, 14),
                    );
                    moodCollection.add({
                      'email': email,
                      'mood': selectedNumber,
                      'date': date.text,
                      'description': description.text,
                      'latitude': latLng.latitude,
                      'longitude': latLng.longitude,
                    });
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Mood Anda Sudah Terekam!',
                      confirmBtnColor: Colors.blue,
                      backgroundColor: Colors.white,
                    );
                    description.clear();
                    setState(() {
                      selectedNumber = null;
                      date.clear();
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Terjadi kesalahan. Silakan coba lagi',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
