import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_type/image_picker_type.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sample Imagepicker Widget"),
          backgroundColor: Colors.black45,
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.black12,
                  height: 300.0,
                  width: 900.0,
                  // ignore: unnecessary_null_comparison
                  child: _image == null
                      ? Text("Still waiting!")
                      : Image.file(_image),
                ),
                TextButton(
                  //color: Colors.deepOrangeAccent,
                  child: Text(
                    "Select Image",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // show bottom sheet to select image option
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return ImagePickerHelper(
                            // isSave: true,  //if you want to save image in directory
                            size: Size(300, 300),
                            onDone: (file) {
                              if (file == null) {
                                print(null);
                              } else {
                                setState(() {
                                  _image = file;
                                });
                              }
                            },
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
