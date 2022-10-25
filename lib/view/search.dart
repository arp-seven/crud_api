import 'package:flutter/material.dart';

import '../model/model.dart';
import '../service/muridService.dart';

// ignore: must_be_immutable
class SearchMurid extends StatefulWidget {
  late String keyword;

  SearchMurid({required this.keyword});

  @override
  State<SearchMurid> createState() => _SearchMuridState();
}

class _SearchMuridState extends State<SearchMurid> {
  late Future data;
  List<Murid> data2 = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  bool cekData = true;

  @override
  void initState() {
    data = MuridService().getMurid();
    data.then((value) {
      setState(() {
        data2 = value;
        data2 = data2
            .where((element) =>
                element.nameMurid
                    .toLowerCase()
                    .contains(widget.keyword.toLowerCase()) ||
                element.kelasId
                    .toString()
                    .toLowerCase()
                    .contains(widget.keyword.toLowerCase()))
            .toList();
        if (data2.length == 0) {
          cekData = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(
                "Page Pencarian",
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
        iconTheme: IconThemeData(color: Colors.black),
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
          ? cekData
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )
              : Center(
                  child: Text(
                    "Data tidak ditemukan",
                    style: TextStyle(fontSize: 30),
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
    );
  }
}
