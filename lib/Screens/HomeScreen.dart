import 'dart:convert';

import 'package:covid_tracker/model/post_model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            currentIndex: selectedIndex,
            backgroundColor: Color.fromRGBO(0, 46, 110, 1),
            selectedItemColor: Colors.white,
            elevation: 12,
            unselectedItemColor: Colors.blueGrey[200],
            enableFeedback: true,
            selectedFontSize: 8,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            selectedIconTheme: IconThemeData(size: 34),
            items: [
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.house_rounded),
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.house_outlined),
                  label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search")
            ]),
        drawer: Drawer(
            child: Column(
          children: [Text("hello"), Text("world")],
        )),
        drawerEnableOpenDragGesture: true,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 46, 110, 1),
          foregroundColor: Colors.white,
          title: Text("API",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading...");
              } else {
                return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 250,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(children: [
                              Text(postList[index].title.toString()),
                              Text(postList[index].body.toString())
                            ]),
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}
