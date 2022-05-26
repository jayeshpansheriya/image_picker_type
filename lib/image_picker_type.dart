library image_picker_type;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum ImagePickerType { GALLERY, CAMERA }

class ImagePickerHelper extends StatelessWidget {
  const ImagePickerHelper(
      {Key? key,
      required this.onDone,
      required this.size,
      this.androidUiSettings,
      this.iosUiSettings})
      : super(key: key);

  final Function(File?) onDone;
  final Size size;
  final AndroidUiSettings? androidUiSettings;
  final IOSUiSettings? iosUiSettings;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text('Gallery '),
            onTap: () async {
              getCroppedImage(ImagePickerType.GALLERY).then((img) async {
                Navigator.pop(context);
                onDone(File(img!.path));
              });
            },
          ),
          new ListTile(
            title: new Text('Camera'),
            onTap: () async {
              getCroppedImage(ImagePickerType.CAMERA).then((img) async {
                Navigator.pop(context);
                onDone(File(img!.path));
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

  Future<CroppedFile?> getCroppedImage(ImagePickerType type) async {
    final ImagePicker picker = ImagePicker();

    return picker
        .pickImage(
            source: type == ImagePickerType.CAMERA
                ? ImageSource.camera
                : ImageSource.gallery)
        .then((img) {
      return ImageCropper().cropImage(
          sourcePath: img!.path,
          maxHeight: size.height.toInt(),
          maxWidth: size.width.toInt(),
          aspectRatio: CropAspectRatio(
              ratioX: size.height.toDouble(), ratioY: size.width.toDouble()),
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          uiSettings: [
            androidUiSettings ??
                AndroidUiSettings(
                    toolbarTitle: 'Cropper',
                    toolbarColor: Colors.deepOrange,
                    toolbarWidgetColor: Colors.white,
                    initAspectRatio: CropAspectRatioPreset.original,
                    lockAspectRatio: false),
            iosUiSettings ??
                IOSUiSettings(
                  minimumAspectRatio: 1.0,
                )
          ]);
    });
  }
}
