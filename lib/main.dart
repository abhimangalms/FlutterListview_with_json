import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/** Created by Abhimangal 05.11.2019*/

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            elevation: 8.0,
            margin:
                EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
            color: Colors.white,
            child: new Container(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.accessibility,
                              color: const Color(0xFF666565)),
                          new Container(
                              margin: EdgeInsets.only(left: 5.0),
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 300),
                              child: Text(
                                data[index]["title"],
                                style: new TextStyle(
                                    fontSize: 16.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto"),
                                maxLines: 1,
                              ))
                        ]),
                    new Container(
                      alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 15.0),
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 300),
                        child: Text(
                          data[index]["body"],
                          style: new TextStyle(
                              fontSize: 14.0,
                              color: const Color(0xFF2d2424),
                              fontWeight: FontWeight.w300,
                              fontFamily: "Roboto"),
                          maxLines: 4,
                        ))
                  ]),
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 15.0, bottom: 15.0),
              alignment: Alignment.center,
            ),
          );
        },
      ),
    );
  }
}
