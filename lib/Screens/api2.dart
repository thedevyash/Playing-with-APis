import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api2 extends StatefulWidget {
  const Api2({super.key});

  @override
  State<Api2> createState() => _Api2State();
}

class _Api2State extends State<Api2> {
  List<PhotosModel> photosList = [];

  Future<List<PhotosModel>> getapi2() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        PhotosModel photo = PhotosModel(title: i['title'], url: i['url']);
        photosList.add(photo);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("APi2"),
        ),
        body: FutureBuilder(
            future: getapi2(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading...");
              } else {
                return Expanded(
                    child: ListView.builder(
                        itemCount: photosList.length,
                        itemBuilder: (context, index) {
                          return Text("Hello World");
                        }));
              }
            }));
  }
}

class PhotosModel {
  String title, url;
  PhotosModel({required this.title, required this.url});
}
