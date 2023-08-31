import 'package:flutter/material.dart';

class Snipe extends StatefulWidget {
  @override
  _SnipeState createState() => _SnipeState();
}

class _SnipeState extends State<Snipe> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Title'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
        ),
        body: new Container(
          child: Text('hola mundo',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black)),
        ),
      ),
    );
  }
}