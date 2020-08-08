library image_picker_type;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum ImagePickerType { GALLERY, CAMERA }

class ImagePickerHelper extends StatelessWidget {

  const ImagePickerHelper({Key key, this.onDone, this.isSave = false, this.size})
      : super(key: key);

  final Function(File) onDone;
  final bool isSave;
  final Size size;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text('Gallery '),
            onTap: () async {
              getCroppedImage(ImagePickerType.GALLERY, size.height, size.width)
                  .then((img) async {
                Navigator.pop(context);
                 if (!Directory("/storage/emulated/0/Images")
                .existsSync()) {
              Directory("/storage/emulated/0/Images")
                  .createSync(recursive: true);
            }
                  // copy the file to a new path
                  final File newImage = await img.copy('/storage/emulated/0/Images/${DateTime.now().toString()}.png');
                onDone(img);
              });
            },
          ),
          new ListTile(
            title: new Text('Camera'),
            onTap: () async {
              getCroppedImage(ImagePickerType.CAMERA, size.height, size.width)
                  .then((img) async {
                Navigator.pop(context);
                if (!Directory("/storage/emulated/0/Images")
                .existsSync()) {
              Directory("/storage/emulated/0/Images")
                  .createSync(recursive: true);
            }
                  // copy the file to a new path
                  final File newImage = await img.copy('/storage/emulated/0/Images/${DateTime.now().toString()}.png');
               
                onDone(img);
              });
            },
          ),
          new ListTile(
            title: new Text('Cancel', style: new TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              onDone(null);
            },
          ),
        ],
      ),
    );
  }

  Future<File> getCroppedImage(
      ImagePickerType type, double height, double width) async {
    final picker = ImagePicker();

    return picker.getImage(
        source: type == ImagePickerType.CAMERA
            ? ImageSource.camera
            : ImageSource.gallery)
        .then((img) {
      return ImageCropper.cropImage(
          sourcePath: img.path,
          maxHeight: height.toInt(),
          maxWidth: width.toInt(),
          aspectRatio: CropAspectRatio(
              ratioX: height.toDouble(), ratioY: width.toDouble()),
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
    });
  }

}
