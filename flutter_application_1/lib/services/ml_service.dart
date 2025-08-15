import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import '../utils/constants.dart';

class MLService {
  static final MLService _instance = MLService._internal();
  factory MLService() => _instance;
  MLService._internal();

  Interpreter? _interpreter;
  bool _isModelLoaded = false;

  bool get isModelLoaded => _isModelLoaded;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(AppConstants.modelAssetPath);
      _isModelLoaded = true;
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  Future<String> predictDigit(GlobalKey signatureKey,
      {Uint8List? selectedImage}) async {
    if (!_isModelLoaded) {
      return '';
    }

    Uint8List? imageData = selectedImage;

    if (imageData == null) {
      RenderRepaintBoundary boundary = signatureKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        print('Byte data is null');
        return '';
      }
      imageData = byteData.buffer.asUint8List();
    }

    // Process image
    img.Image originalImage = img.decodeImage(imageData)!;
    img.Image resizedImage =
        img.copyResize(originalImage, width: 28, height: 28);
    resizedImage = img.grayscale(resizedImage);

    // Prepare input
    var input = Float32List(1 * 28 * 28 * 1);
    var buffer = Float32List.view(input.buffer);

    for (int i = 0; i < 28 * 28; i++) {
      int x = i % 28;
      int y = i ~/ 28;
      var pixel = resizedImage.getPixel(x, y);
      double grayscale = img.getLuminance(pixel) / 255.0;
      buffer[i] = grayscale;
    }

    // Run prediction
    var output = List.filled(10, 0.0).reshape([1, 10]);
    _interpreter!.run(input.reshape([1, 28, 28, 1]), output);

    var predictedIndex = output[0].indexWhere((element) =>
        element == output[0].reduce((double a, double b) => a > b ? a : b));

    return predictedIndex.toString();
  }

  void dispose() {
    _interpreter?.close();
  }
}
