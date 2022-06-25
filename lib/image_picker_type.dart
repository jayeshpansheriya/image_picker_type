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
      this.androidSettings,
      this.iosSettings})
      : super(key: key);

  final Function(File?) onDone;
  final Size size;
  final AndroidSetting? androidSettings;
  final IOSSettings? iosSettings;

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
            AndroidUiSettings(
              toolbarTitle: androidSettings?.toolbarTitle,
              toolbarColor: androidSettings?.toolbarColor,
              statusBarColor: androidSettings?.statusBarColor,
              toolbarWidgetColor: androidSettings?.toolbarWidgetColor,
              backgroundColor: androidSettings?.backgroundColor,
              activeControlsWidgetColor:
                  androidSettings?.activeControlsWidgetColor,
              dimmedLayerColor: androidSettings?.dimmedLayerColor,
              cropFrameColor: androidSettings?.cropFrameColor,
              cropGridColor: androidSettings?.cropGridColor,
              cropFrameStrokeWidth: androidSettings?.cropFrameStrokeWidth,
              cropGridRowCount: androidSettings?.cropGridRowCount,
              cropGridColumnCount: androidSettings?.cropGridColumnCount,
              cropGridStrokeWidth: androidSettings?.cropGridStrokeWidth,
              showCropGrid: androidSettings?.showCropGrid,
              lockAspectRatio: androidSettings?.lockAspectRatio,
              hideBottomControls: androidSettings?.hideBottomControls,
              initAspectRatio: androidSettings?.initAspectRatio,
            ),
            IOSUiSettings(
              minimumAspectRatio: iosSettings?.minimumAspectRatio,
              rectX: iosSettings?.rectX,
              rectY: iosSettings?.rectY,
              rectWidth: iosSettings?.rectWidth,
              rectHeight: iosSettings?.rectHeight,
              showActivitySheetOnDone: iosSettings?.showActivitySheetOnDone,
              showCancelConfirmationDialog:
                  iosSettings?.showCancelConfirmationDialog ?? false,
              rotateClockwiseButtonHidden:
                  iosSettings?.rotateClockwiseButtonHidden ?? false,
              hidesNavigationBar: iosSettings?.hidesNavigationBar,
              rotateButtonsHidden: iosSettings?.rotateButtonsHidden ?? false,
              resetButtonHidden: iosSettings?.resetButtonHidden ?? false,
              aspectRatioPickerButtonHidden:
                  iosSettings?.aspectRatioPickerButtonHidden ?? false,
              resetAspectRatioEnabled:
                  iosSettings?.resetAspectRatioEnabled ?? true,
              aspectRatioLockDimensionSwapEnabled:
                  iosSettings?.aspectRatioLockDimensionSwapEnabled ?? false,
              aspectRatioLockEnabled:
                  iosSettings?.aspectRatioLockEnabled ?? false,
              title: iosSettings?.title,
              doneButtonTitle: iosSettings?.doneButtonTitle,
              cancelButtonTitle: iosSettings?.cancelButtonTitle,
            )
          ]);
    });
  }
}

class AndroidSetting {
  /// desired text for Toolbar title
  final String? toolbarTitle;

  /// desired color of the Toolbar
  final Color? toolbarColor;

  /// desired color of status
  final Color? statusBarColor;

  /// desired color of Toolbar text and buttons (default is black)
  final Color? toolbarWidgetColor;

  /// desired background color that should be applied to the root view
  final Color? backgroundColor;

  /// desired resolved color of the active and selected widget and progress wheel middle line (default is darker orange)
  final Color? activeControlsWidgetColor;

  /// desired color of dimmed area around the crop bounds
  final Color? dimmedLayerColor;

  /// desired color of crop frame
  final Color? cropFrameColor;

  /// desired color of crop grid/guidelines
  final Color? cropGridColor;

  /// desired width of crop frame line in pixels
  final int? cropFrameStrokeWidth;

  /// crop grid rows count
  final int? cropGridRowCount;

  /// crop grid columns count
  final int? cropGridColumnCount;

  /// desired width of crop grid lines in pixels
  final int? cropGridStrokeWidth;

  /// set to true if you want to see a crop grid/guidelines on top of an image
  final bool? showCropGrid;

  /// set to true if you want to lock the aspect ratio of crop bounds with a fixed value
  /// (locked by default)
  final bool? lockAspectRatio;

  /// set to true to hide the bottom controls (shown by default)
  final bool? hideBottomControls;

  /// desired aspect ratio is applied (from the list of given aspect ratio presets)
  /// when starting the cropper
  final CropAspectRatioPreset? initAspectRatio;

  AndroidSetting({
    this.toolbarTitle,
    this.toolbarColor,
    this.statusBarColor,
    this.toolbarWidgetColor,
    this.backgroundColor,
    this.activeControlsWidgetColor,
    this.dimmedLayerColor,
    this.cropFrameColor,
    this.cropGridColor,
    this.cropFrameStrokeWidth,
    this.cropGridRowCount,
    this.cropGridColumnCount,
    this.cropGridStrokeWidth,
    this.showCropGrid,
    this.lockAspectRatio,
    this.hideBottomControls,
    this.initAspectRatio,
  });
}

class IOSSettings {
  /// The minimum croping aspect ratio. If set, user is prevented from setting
  /// cropping rectangle to lower aspect ratio than defined by the parameter.
  final double? minimumAspectRatio;

  /// The initial rect of cropping.
  final double? rectX;
  final double? rectY;
  final double? rectWidth;
  final double? rectHeight;

  /// If true, when the user hits 'Done', a UIActivityController will appear
  /// before the view controller ends.
  final bool? showActivitySheetOnDone;

  /// Shows a confirmation dialog when the user hits 'Cancel' and there are pending changes.
  /// (default is false)
  final bool showCancelConfirmationDialog;

  /// When disabled, an additional rotation button that rotates the canvas in
  /// 90-degree segments in a clockwise direction is shown in the toolbar.
  /// (default is false)
  final bool rotateClockwiseButtonHidden;

  /// If this controller is embedded in UINavigationController its navigation bar
  /// is hidden by default. Set this property to false to show the navigation bar.
  /// This must be set before this controller is presented.
  final bool? hidesNavigationBar;

  /// When enabled, hides the rotation button, as well as the alternative rotation
  /// button visible when `showClockwiseRotationButton` is set to YES.
  /// (default is false)
  final bool rotateButtonsHidden;

  /// When enabled, hides the 'Reset' button on the toolbar.
  /// (default is false)
  final bool resetButtonHidden;

  /// When enabled, hides the 'Aspect Ratio Picker' button on the toolbar.
  /// (default is false)
  final bool aspectRatioPickerButtonHidden;

  /// If true, tapping the reset button will also reset the aspect ratio back to the image
  /// default ratio. Otherwise, the reset will just zoom out to the current aspect ratio.
  ///
  /// If this is set to false, and `aspectRatioLockEnabled` is set to true, then the aspect ratio
  /// button will automatically be hidden from the toolbar.
  ///
  /// (default is true)
  final bool resetAspectRatioEnabled;

  /// If true, a custom aspect ratio is set, and the aspectRatioLockEnabled is set to true, the crop box
  /// will swap it's dimensions depending on portrait or landscape sized images.
  /// This value also controls whether the dimensions can swap when the image is rotated.
  ///
  /// (default is false)
  final bool aspectRatioLockDimensionSwapEnabled;

  /// If true, while it can still be resized, the crop box will be locked to its current aspect ratio.
  ///
  /// If this is set to true, and `resetAspectRatioEnabled` is set to false, then the aspect ratio
  /// button will automatically be hidden from the toolbar.
  ///
  /// (default is false)
  final bool aspectRatioLockEnabled;

  /// Title text that appears at the top of the view controller.
  final String? title;

  /// Title for the 'Done' button.
  /// Setting this will override the Default which is a localized string for "Done".
  final String? doneButtonTitle;

  /// Title for the 'Cancel' button.
  /// Setting this will override the Default which is a localized string for "Cancel".
  final String? cancelButtonTitle;

  IOSSettings({
    this.minimumAspectRatio,
    this.rectX,
    this.rectY,
    this.rectWidth,
    this.rectHeight,
    this.showActivitySheetOnDone,
    this.showCancelConfirmationDialog = false,
    this.rotateClockwiseButtonHidden = false,
    this.hidesNavigationBar,
    this.rotateButtonsHidden = false,
    this.resetButtonHidden = false,
    this.aspectRatioPickerButtonHidden = false,
    this.resetAspectRatioEnabled = true,
    this.aspectRatioLockDimensionSwapEnabled = false,
    this.aspectRatioLockEnabled = false,
    this.title,
    this.doneButtonTitle,
    this.cancelButtonTitle,
  });
}
