

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePage createState()=>_HomePage();
}

class _HomePage extends State<HomePage>
{
  Widget build(BuildContext context)
  {
    return Scaffold(
        body:Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title:Text("About OCR",style: TextStyle(fontSize: 34.0),),
                subtitle: Text("Optical character recognition or optical character reader is the electronic or mechanical conversion of images of typed, handwritten or printed text into machine-encoded text, whether from a scanned document, a photo of a document, a scene-photo or from subtitle text superimposed on an image."
                  ,style: TextStyle(fontSize: 20.0),),

              ),
              const Text("Created by Chrosact"),
            ],
          ),
        ),

    );
  }
}