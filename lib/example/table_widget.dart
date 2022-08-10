import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Flutter Table Sample"),
      ),
      body: Column(
          children:<Widget>[
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Ballon d’Or",textScaleFactor: 2,style: TextStyle(fontWeight:FontWeight.bold),),
    ),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Table(
    children: [
    TableRow(
    children: [
      Text("Winners"),
      Text("Year"),
      Text("Country"),
      Text("Club Name"),
    ]
    ),
    TableRow(
    children: [
      Text("Ronaldo"),
      Text("1997"),
      Text("Brazil"),
      Text("Internazionale"),
    ]
    ),
    TableRow(
    children: [
      Text("Zinedine Zidane"),
      Text("1998"),
      Text("France"),
      Text("Juventus"),
    ]
    ),
    TableRow(
    children: [
      Text("Rivaldo"),
      Text("1999"),
      Text("Brazil"),
      Text("Barcelona"),
    ]
    )
    ],
    ),
    ),
    ]
    ),
    );
  }
}