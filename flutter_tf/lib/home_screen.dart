import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String modelPath = "assets/model_unquant.tflite";
  String labelPath = "assets/labels.txt";
  double similarityPercent = 0.0;
  ImagePicker pick = ImagePicker();
  List resultClassifiy;
  PickedFile file;
  bool isLoading = false;
  void takeImage(ImageSource source) async {
    var _tempFile = await pick.getImage(source: source);
    if (_tempFile != null) {
      setState(() {
        isLoading = true;
        file = _tempFile;
      });
    }
    classifyImage(File(_tempFile.path));
  }

  void classifyImage(File image) async {
    /// Load models
    await Tflite.loadModel(model: modelPath, labels: labelPath);
    var result = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      isLoading = false;
      resultClassifiy = result;
      print("Data $resultClassifiy");
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tensorflow test"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              file != null
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.file(
                            File(file.path),
                            height: scrHeight / scrHeight * 400,
                            width: scrHeight / scrHeight * 250,
                          ),
                        ),
                        Container(
                          height: scrHeight / scrHeight * 300,
                          width: scrHeight / scrHeight * 200,
                          child: Text( "Hallo Ges", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                            )
                          ),
                        ),
                      ],
                    )
                  : Center(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: 45,
                        width: double.infinity,
                        child: RaisedButton.icon(
                          icon: Icon(Icons.camera_alt),
                          label: Text("Camera"),
                          onPressed: () {
                            takeImage(ImageSource.camera);
                          },
                        )),
                  ),
                  Flexible(
                    child: Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: RaisedButton.icon(
                          icon: Icon(Icons.photo),
                          label: Text("Galery"),
                          onPressed: () {
                            takeImage(ImageSource.gallery);
                          },
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
