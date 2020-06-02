import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OcrPage extends StatefulWidget {
  static var tag = "/ocr";

  @override
  _OcrPageState createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  File pickedImage;

  bool isImageLoaded = false;



  Future<void> pickImage() async {
    final tempImageFile =
        await ImagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
    setState(() {
      pickedImage = tempImageFile;
      isImageLoaded = true;
    });
    readText();
  }

  Future readText() async{
    FirebaseVisionImage image = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizer.processImage(image);
    for (TextBlock block in readText.blocks){
      for(TextLine line in block.lines){
        for (TextElement word in line.elements)
          print(word.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent, );
  }

  @override
  void initState() {
    super.initState();
    pickImage();
  }
}
