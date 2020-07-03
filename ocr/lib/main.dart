import 'package:flutter/material.dart';
import 'home.dart';
import 'live_ocr.dart';
import 'select_ocr.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _MyApp();
  }
}
class _MyApp extends State<MyApp>{




  int _selectedPage = 0;
  final _pageOption = <Widget>[
    HomePage(),
    LivePage(),
    SelectPage(),
  ];
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[900],
      ),
      home: Scaffold(
        appBar: AppBar(title:Text("OCR",textAlign: TextAlign.center,),),
        body: _pageOption[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap:(int index){
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home Page"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text("Live OCR"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              title: Text("OCR CAPTURE"),
            ),
          ],
        ),
      ),
    );
  }
}

