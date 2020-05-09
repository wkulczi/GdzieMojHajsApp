import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OcrPage extends StatefulWidget {
  @override
  _OcrPageState createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  File pickedImage;

  bool isImageLoaded = false;

  Future<void> attackCarthage() async {
    final tempImageFile =
    await ImagePicker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);

    setState(() {
      pickedImage = tempImageFile;
      isImageLoaded = true;
    });
  }

  Future readText() async {
    FirebaseVisionImage image = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizer.processImage(image);
    for (TextBlock block in readText.blocks){
      print("NEWBLOCK");
      for (TextLine line in block.lines){
        print("NEWLINE");
        for (TextElement word in line.elements){
          print(word.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(child: RaisedButton(
          onPressed: readText,
          child: Text("Read text"),
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: attackCarthage,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
