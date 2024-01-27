import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bulb extends StatefulWidget {
  const Bulb({super.key});

  @override
  State<Bulb> createState() => _BulbState();
}

class _BulbState extends State<Bulb> {
  bool bulbStatus = false;
  bool switchStatus = false;
  @override
  void initState(){
    //first time App Runs
    readStoreValue();
    super.initState();
  }

  readStoreValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  //get previously stored value if any
    bulbStatus = prefs.getBool('bulbStatus') ?? false; // await prefs.setBool('bulbStatus', false);
  }

  @override
  Widget build(BuildContext context) {
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
                setState(()  async {
                  //bulbStatus = value;
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  bulbStatus = await prefs.setBool('bulbStatus', value);
                });
              }),
        ],
      ),
    );
  }
}
