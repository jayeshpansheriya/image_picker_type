# image_picker_type plugin for Flutter

A Flutter plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera or gallery and crop it.

## Features

- [X] iOS Support
- [X] Android Support

## Installation

First, add `image_picker_type`.

### iOS

Add the following keys to your _Info.plist_ file, located in `<project root>/ios/Runner/Info.plist`:

* `NSPhotoLibraryUsageDescription` - describe why your app needs permission for the photo library. This is called _Privacy - Photo Library Usage Description_ in the visual editor.
* `NSCameraUsageDescription` - describe why your app needs access to the camera. This is called _Privacy - Camera Usage Description_ in the visual editor.
* `NSMicrophoneUsageDescription` - describe why your app needs access to the microphone, if you intend to record videos. This is called _Privacy - Microphone Usage Description_ in the visual editor.

### Android

#### API 29+
No configuration required - the plugin should work out of the box.

#### API < 29

Add `android:requestLegacyExternalStorage="true"` as an attribute to the `<application>` tag in AndroidManifest.xml. The [attribute](https://developer.android.com/training/data-storage/compatibility) is `false` by default on apps targeting Android Q.


### Example

``` dart
// show bottom sheet to select image option
showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return ImagePickerHelper(
        isCropped: true,
        size: Size(300, 300),
        onDone: (file) {
          if (file == null) {
            print(null);
          } else {
           setState(() {
                 File file = file;
            });
          }
        },
      );
    });
```

![example](https://github.com/jayeshpansheriya/image_picker_type/blob/master/android_demo.gif)
## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
