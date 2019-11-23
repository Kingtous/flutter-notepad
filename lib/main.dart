import 'package:flutter/material.dart';
import 'package:music_player/input.dart';
import 'package:music_player/list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '记事本',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '记事本'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RecordList(),
      floatingActionButton: Padding(
        child:
        FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(new PageRouteBuilder(pageBuilder: (BuildContext context,Animation animation,Animation secondaryAnimation){
              return FadeTransition(
                opacity: animation,
                child: InputPage(),
              );
            }));
          },
          tooltip: "你按这么久干啥？",
          backgroundColor: Colors.blue,
          icon: Icon(Icons.add_comment),
          label: Text("添加记录"),
        ), 
        padding: EdgeInsets.fromLTRB(0,0,0,16),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
