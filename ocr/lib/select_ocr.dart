import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class Data {
  var iimage;
  Data({this.iimage});
}


class SelectPage extends StatefulWidget{
@override
_SelectPage createState()=>_SelectPage();
}

class _SelectPage extends State<SelectPage>
{


  File pickedImage;
  bool isImageLoaded = false;
  Future _pickimage() async{
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = image;
      isImageLoaded = true;
    });
    _showMyDialog();
}

  Future _pickimage2() async{
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(image==null)
      _SelectPage();

    setState(() {
      pickedImage = image;
      isImageLoaded = true;
    });
    _showMyDialog();
  }

  var text="";
  Future _read() async{
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {

      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            text = text + word.text + ' ';
          });
        }
        text = text + '\n';
      }
    }
    textRecognizer.close();

    var data =   new Data();
    data.iimage = text;
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) =>  Textread(data:data)),);
  }


Future<void> _showMyDialog() async { // for read and check
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Would you like to extract text from Selected Image?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: _read,
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

        ],
      );
    },
  );
}

  Future<void> _showMyDialog2() async { //camera option
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Source Option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Chose Your Camera option?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Gallery'),
              onPressed: _pickimage,
            ),
            FlatButton(
              child: Text('Camera'),
              onPressed:_pickimage2,
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            isImageLoaded
                ? Center(
              child: Container(
                  height: 400.0,
                  width: 500.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(pickedImage), fit: BoxFit.cover))),
            )
                : Center(
              child: Container(
                child: Text("NO IMAGE SELECTED",style: TextStyle(fontSize: 20.0),),
                  ),
              ),

            //SizedBox(height: 10.0),
          ],
        ),
      floatingActionButton: FloatingActionButton(onPressed: _showMyDialog2, child: Icon(Icons.camera_alt),),
    );
  }
}

class Textread extends StatefulWidget{
  @override
  final Data data;
  Textread({this.data});
  _Textread createState()=>_Textread(data:data);
}

class _Textread extends State<Textread>
{
  final Data data;
  _Textread({this.data});




  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title:Text("Extractd Text form File")),
      body: Text(data.iimage,style:TextStyle(fontSize: 20.0),),
    );
  }
}