import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';

class ShowDistanceScreen extends StatefulWidget {
  ShowDistanceScreen(this.ipAddr);

  final String ipAddr;

  @override
  _ShowDistanceScreenState createState() => _ShowDistanceScreenState();
}

class _ShowDistanceScreenState extends State<ShowDistanceScreen> {
  Future<dynamic> _future;

  int standardDistance = 2000;

  bool _canVibrate = true;
  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 500),
  ];

  vibrateConfig() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate
          ? print("This device can vibrate")
          : print("This device cannot vibrate");
    });
  }

  Future<dynamic> getDistance() async {
    var url = Uri.parse(widget.ipAddr);
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      print("--request--");
      if (this.mounted) {
        setState(() {
          _future = getDistance();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setUpTimedFetch();
    vibrateConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Error"),
            );
          }
          // print(snapshot.toString());

          if (!snapshot.hasData) {
            return Center(
              child: Text("No Data"),
            );
          }
          bool temp = false;
          if (snapshot.data['distance'] < standardDistance) {
            print("vibrate------");
            Vibrate.vibrate();
            temp = true;
          }
          return Container(
              color: temp ? Colors.red : null,
              child: Center(
                child: Text(
                  snapshot.data['distance'].toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ));
        },
      ),
    );
  }
}
