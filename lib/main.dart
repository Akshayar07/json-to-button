import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:ui';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _days = [];
  late int tappedIndex;

  void initState() {
    super.initState();
    tappedIndex = -1;
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/schedule_day.json');
    final data = await json.decode(response);
    setState(() {
      _days = data["days"];
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Scaffold(
      backgroundColor: Color(0xffb3ead4),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Days'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _days.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                        children: [
                          Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: tappedIndex == index
                                        ? Colors.teal
                                        : Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      tappedIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _days[index]["name"],
                                      style:
                                          TextStyle(fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                ),
                         ),

                        ],
                      );

                  }),
            ],
          ),
        ),
      ),
    );
  }
}


