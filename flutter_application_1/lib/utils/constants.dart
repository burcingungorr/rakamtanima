import 'package:flutter/material.dart';

class AppConstants {
  static const Color primaryColor = Colors.orange;
  static const Color backgroundColor = Colors.black;
  static const Color textColor = Colors.white;

  static const double penStrokeWidth = 30.0;
  static const double buttonSize = 120.0;
  static const double titleFontSize = 70.0;
  static const double levelButtonFontSize = 40.0;

  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration audioDelay = Duration(seconds: 2);

  static const String modelAssetPath = 'assets/mnist.tflite';
}

class AudioFiles {
  static const String levelSelection = 'seviyenisec.mp3';
  static const String timeUp = 'surebitmeden.mp3';
  static const String congratulations = 'tebrikler.mp3';
  static const String tryAgain = 'tekrardenemelisin.mp3';
  static const String writeWhatYouKnow = 'bildikleriniyaz.mp3';

  // Number audio files
  static const String zero = 'sifir.mp3';
  static const String one = 'bir.mp3';
  static const String two = 'iki.mp3';
  static const String three = 'uc.mp3';
  static const String four = 'dort.mp3';
  static const String five = 'bes.mp3';
  static const String six = 'alti.mp3';
  static const String seven = 'yedi.mp3';
  static const String eight = 'sekiz.mp3';
  static const String nine = 'dokuz.mp3';
}
