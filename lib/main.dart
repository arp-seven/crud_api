import 'dart:async';
import 'dart:ui';

import 'package:crud_api/service/muridService.dart';
import 'package:crud_api/view/addData.dart';
import 'package:crud_api/view/search.dart';
import 'package:flutter/material.dart';

import 'model/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan CRUD - API',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future data;
  List<Murid> data2 = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();

  void ambilData() {
    data = MuridService().getMurid();
    data.then((value) {
      setState(() {
        data2 = value;
      });
    });
  }

  FutureOr onGoBack(dynamic value) {
    ambilData();
  }

  void navigateAddData() {
    Route route = MaterialPageRoute(builder: (context) => AddMurid());
    Navigator.push(context, route).then(onGoBack);
  }

  @override
  void initState() {
    ambilData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(
                "Data Murid",
                style: TextStyle(color: Colors.black, fontSize: 26),
              )
            : TextField(
                controller: searchText,
                style: TextStyle(color: Colors.black, fontSize: 26),
                decoration: InputDecoration(
                    hintText: "Cari", hintStyle: TextStyle(color: Colors.grey)),
                onSubmitted: (value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SearchMurid(keyword: searchText.text)));
                },
              ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  this.isSearching = !this.isSearching;
                });
              },
              icon: !isSearching
                  ? Icon(Icons.search, color: Colors.black)
                  : Icon(Icons.cancel, color: Colors.black))
        ],
      ),
      body: data2.length == 0
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView.builder(
              itemCount: data2.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data2[index].nameMurid),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateAddData();
        },
        tooltip: "Tambah Data",
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}
