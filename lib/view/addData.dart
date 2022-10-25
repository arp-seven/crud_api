// import 'dart:ffi';

import 'package:crud_api/model/model.dart';
import 'package:crud_api/view/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:crud_api/service/muridService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddMurid extends StatefulWidget {
  const AddMurid({super.key});

  @override
  State<AddMurid> createState() => _AddMuridState();
}

class _AddMuridState extends State<AddMurid> {
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  TextEditingController nisnController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  String? jenisKelamin;
  int count = 0;

  void createData() {
    MuridService()
        .saveMurid(
            nisnController.text,
            nameController.text,
            emailController.text,
            phoneController.text,
            addressController.text,
            jenisKelamin!,
            kelasController.text)
        .then((value) {
      setState(() {
        if (value) {
          Alert(
              context: context,
              title: "Berhasil",
              desc: "Data Telah Disimpan",
              type: AlertType.success,
              buttons: [
                DialogButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  },
                ),
              ]).show();
        } else {
          Alert(
              context: context,
              title: "Gagal",
              desc: "Data Gagal Disimpan",
              type: AlertType.error,
              buttons: [
                DialogButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ]).show();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(
                "Add Data",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nisnController,
              decoration: InputDecoration(
                  hintText: "Masukan NISN",
                  labelText: "NISN Murid",
                  icon: Icon(Icons.assignment_outlined)),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Masukan Nama",
                  labelText: "Nama Murid",
                  icon: Icon(Icons.people)),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Masukan Email",
                  labelText: "Email Murid",
                  icon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  hintText: "Masukan No HP",
                  labelText: "No Hp Murid",
                  icon: Icon(Icons.phone)),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                  hintText: "Masukan Alamat",
                  labelText: "Alamat Murid",
                  icon: Icon(Icons.place)),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Radio(
                    value: 'L',
                    groupValue: jenisKelamin,
                    onChanged: (String? value) {
                      setState(() {
                        jenisKelamin = value;
                      });
                    }),
                Text(
                  "L",
                  style: TextStyle(fontSize: 26),
                ),
                Radio(
                    value: 'P',
                    groupValue: jenisKelamin,
                    onChanged: (String? value) {
                      setState(() {
                        jenisKelamin = value;
                      });
                    }),
                Text(
                  "P",
                  style: TextStyle(fontSize: 26),
                ),
              ],
            ),
            SizedBox(height: 5),
            TextField(
              controller: kelasController,
              decoration: InputDecoration(
                  hintText: "Masukan Nama Kelas",
                  labelText: "Kelas Murid",
                  icon: Icon(Icons.house)),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  createData();
                },
                child: Text("Save Data", style: TextStyle(fontSize: 26)))
          ],
        ),
      ),
    );
  }
}
