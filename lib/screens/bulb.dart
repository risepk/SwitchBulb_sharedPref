import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bulb extends StatefulWidget {
  const Bulb({super.key});

  @override
  State<Bulb> createState() => _BulbState();
}

class _BulbState extends State<Bulb> {
  late bool bulbStatus;

  // bool bulbStatus = false;
  @override
  void initState(){
    //("INIT Function Called");
    readStoreValue();
    super.initState();
  }

  readStoreValue() async {
    // print("ReadStoreValue Function Called");
    final prefs = await SharedPreferences.getInstance();
    //get previously stored value if any
    bulbStatus =  prefs.getBool('bulbStatus') ??  false;
    setState(() {

    });
  }
  updateStoreValue(bool value) async {
    //print("UpdateStoreValue Function Called");
    final prefs = await SharedPreferences.getInstance();
    bulbStatus = await prefs.setBool('bulbStatus', value);
  }

  @override
  Widget build(BuildContext context) {
    // print("Build Function Called");
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bulb App'),
      ),
      body: Column(
        children: [
          Icon(
            Icons.lightbulb,
            size:  300,
            color: bulbStatus ? Colors.amber : Colors.black,
          ),
          Switch(
              value: bulbStatus,
              onChanged: (value) {
                setState(() {
                  bulbStatus = value;
                });
                updateStoreValue(value);
              }),
        ],
      ),
    );
  }
}
