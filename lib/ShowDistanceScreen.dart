import 'dart:async';
import 'dart:convert';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:vibrate/vibrate.dart';

enum Result{Error,In,Out}

class ShowDistanceScreen extends StatefulWidget {
  ShowDistanceScreen(this.ipAddr,this.standardDistance);

  final String ipAddr;
  final int standardDistance;

  @override
  _ShowDistanceScreenState createState() => _ShowDistanceScreenState();
}

class _ShowDistanceScreenState extends State<ShowDistanceScreen> {
  Future<dynamic> _future;
  Result result;

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
    Screen.isKeptOn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {

          result = Result.Out;

          if (snapshot.hasError) {
            result = Result.Error;
            print(snapshot.error);
            FlutterBeep.beep();
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
          if (snapshot.data['distance'] < widget.standardDistance) {
            print("vibrate------");
            Vibrate.vibrate();
            FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT);
            result = Result.In;
          }
          return Container(
              color: result==Result.Error ? Colors.yellow : result==Result.In?Colors.red:null,
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
