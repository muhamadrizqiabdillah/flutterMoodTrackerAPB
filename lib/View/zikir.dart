import 'package:flutter/material.dart';
import 'create.dart';
import 'database_instance.dart';
import 'product_model.dart';

class Zikir extends StatefulWidget {
  const Zikir({Key? key}) : super(key: key);

  @override
  State<Zikir> createState() => _ZikirState();
}

class _ZikirState extends State<Zikir> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase(); // Load data from the database
  }

  Future<void> _getDataFromDatabase() async {
    await databaseInstance.database(); // Initialize the database
    setState(() {}); // Trigger a rebuild to display the data
  }

  Future<void> _addDataToDatabase(String data) async {
    await databaseInstance.insert({
      'email': 'example@example.com',
      'jumlah': data,
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zikir gan'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) {
                  return createScreen();
                }),
              ).then((value) =>
                  _getDataFromDatabase()); // Refresh data after returning from the createScreen
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<ProductModel>>(
          future: databaseInstance.all(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else if (snapshot.hasData) {
              final List<ProductModel>? data = snapshot.data;
              if (data == null || data.isEmpty) {
                return Center(child: Text("masih kosong"));
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final ProductModel product = data[index];
                  return ListTile(
                    title: Text(product.jumlah ?? ''),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
