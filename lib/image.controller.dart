// // TODO: import all packages necessary

// // import image from the source (can be from camera or gallery but default is from camera)
// // and crop the image to the specified width and height to 224x224 pixels and the image will not be rotated 
// void _searchByImage(ImageSource source = ImageSource.camera) {
//   final image = await ImagePicker().pickImage(source: source);

//   if (image != null) {
//     final _image = await ImageCropper().cropImage(sourcePath: image.path,
//     androidUiSettings: androidUiSettings(
//       tollbarTitle: "Adjust Image",
//       initAspectRatio: CropAspectRatioPreset.original,
//       lockAspectRatio: true,
//     ),
//     maxHeight: 224,
//     maxWidth: 224,
//     aspectRatio: cropAspectRatio(ratioX: 1, ratioY: 1)
//     );
    
//     // test
//     if (_image != null) {
//       String label = getImageClassificationLabel(_image);
//       print("Label: $label");
//     }
//   }
// }

// // load model image classification with tflite
// void loadModel() async {
//   // TODO: create a directory named assets and make sure that you have the same name of model and labels files
//   var res = await Tflite.loadModel(
//       model: 'assets/model_classification.tflite', labels: 'assets/labels.txt');

//   print("Load model $res");
// }

// // get label from image, using tflite
// Future<String?> getImageClassificationLabel(File file) async {
//   var res =
//       await Tflite.runOnModel(path: file.path, imageMean: 0, imageStd: 255);

//   print(res);
//   return res[0]['label'];
// }
