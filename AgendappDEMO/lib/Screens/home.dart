import 'package:flutter/material.dart';
import 'package:flutter_login_page/Components/MenuOpen.dart';
import 'package:flutter_login_page/Model/Talk.dart';

import 'list_talks.dart';

class MyHomePage extends StatefulWidget {
  final List<Talk> talkList;

  const MyHomePage({Key key, this.talkList}): super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Monday",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: TalkPage(talkList: widget.talkList),
          )
        ],
      )
    );
  }
}