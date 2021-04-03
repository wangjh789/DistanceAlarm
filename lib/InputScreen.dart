import 'package:distance_alarm/ShowDistanceScreen.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    TextEditingController ipInput1 = TextEditingController();
    TextEditingController ipInput2 = TextEditingController();
    TextEditingController ipInput3 = TextEditingController();
    TextEditingController ipInput4 = TextEditingController();
    TextEditingController portInput = TextEditingController();

    String parseToIpAddr(){
      String ipAddr = "http://";
      ipAddr += ipInput1.value.text.trim() + ".";
      ipAddr += ipInput2.value.text.trim() + ".";
      ipAddr += ipInput3.value.text.trim() + ".";
      ipAddr += ipInput4.value.text.trim() + ":";
      ipAddr += portInput.value.text.trim();
      return ipAddr;
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: ListView(
          children: [
            SizedBox(height: 30,),
            Text("IP Address : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(height: 10,),
            Row(children: [
              Flexible(
                child: TextField(
                  controller: ipInput1,
                  keyboardType: TextInputType.datetime,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("."),
              ),
              Flexible(
                child: TextField(
                  controller: ipInput2,
                  keyboardType: TextInputType.datetime,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("."),
              ),
              Flexible(
                child: TextField(
                  controller: ipInput3,
                  keyboardType: TextInputType.datetime,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("."),
              ),
              Flexible(
                child: TextField(
                  controller: ipInput4,
                  keyboardType: TextInputType.datetime,
                ),
              ),
            ],),
            Row(
              children: [
                Text("Port : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Flexible(
                  child: TextField(
                    controller: portInput,
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              print(parseToIpAddr());
              if(parseToIpAddr().length > 20){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowDistanceScreen(parseToIpAddr())));
              }
            }, child: Text("Connect"))
          ],
        ),
      ),
    );
  }
}
