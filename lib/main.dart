import 'dart:async';
import 'dart:convert';
import 'recipes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override

  List<Recipes> userData = [];
  List<Recipes> recipes = [];

  Future MakeList() async {
    http.Response response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/ababicheva/FlutterInternshipTestTask/main/recipes.json")); // считывание данеых по ссылке

    if (response.statusCode == 200) {
      List<dynamic> res = jsonDecode(response.body); // запись в лист мапов данных

      for (int i = 1; i < 11; i++) {
        for (int j = 0; j < 10; j++) {
          Recipes recipe = Recipes.fromJson(res[j]); // создание дубликата класса  Recipes
          if (recipe.id == i) {
            recipes.add(recipe);  // сортировка и запись в лист дубликата класса
          }
        }
      }

    } else {
      throw Exception('Failed to load album');
    }
    setState(() {
      userData = recipes;
    });
  }
  void initState() {
    super.initState();
    MakeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Recipes"),
        backgroundColor: Colors.deepPurple,
        actions: [
          Icon(Icons.search
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child:Padding(
                padding: EdgeInsets.all(25.0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Padding(
                padding: EdgeInsets.all(1.0),
                child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Image(
                      image: NetworkImage(userData[index].picture),
                      width: 150.0,
                      height: 100.0,
                      ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("${userData[index].name} ",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(" ${userData[index].description}",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                    ),
                  ]
                ),
                ),
                Text("${userData[index].id.toString()} ",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
            ],
              ),
              ),
          );
        }
      ),
    );
  }
}




