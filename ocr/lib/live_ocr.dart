import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';


class LivePage extends StatefulWidget{
  @override
  _LivePage createState()=>_LivePage();
}


class _LivePage extends State<LivePage> {

  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "sample";

  Future _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );

      setState(() {
        _textValue = texts[0].value;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  title: Text('OCR in Real Time',style:TextStyle(fontSize: 30.0),),
                  subtitle: Text(
                      'By using MOBLIE VISION we are able to read directly from the source without converting using image'
                      ,style:TextStyle(fontSize: 18.0),),
                ),
              ]
          ),
        ),

      floatingActionButton: FloatingActionButton(onPressed: _read, child: Icon(Icons.camera),),

    );
  }
}


