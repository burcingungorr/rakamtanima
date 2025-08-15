import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../models/media_model.dart';
import '../utils/constants.dart';
import 'level_three_drawing_screen.dart';

class ThirdLevelPage extends StatefulWidget {
  final int level;

  ThirdLevelPage({required this.level});

  @override
  _ThirdLevelPageState createState() => _ThirdLevelPageState();
}

class _ThirdLevelPageState extends State<ThirdLevelPage> {
  final AudioService _audioService = AudioService();
  late String _selectedImage;
  late String _correctNumber;

  @override
  void initState() {
    super.initState();
    _selectRandomMedia();

    Timer(AppConstants.splashDuration, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LevelThreeDrawingScreen(
            correctNumber: _correctNumber,
            level: widget.level + 1,
          ),
        ),
      );
    });
  }

  void _selectRandomMedia() {
    final random = Random();
    final randomIndex = random.nextInt(MediaData.mediaListWithoutAudio.length);
    final selectedMedia = MediaData.mediaListWithoutAudio[randomIndex];

    _selectedImage = selectedMedia.image;
    _correctNumber = selectedMedia.number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            right: 0.0,
            top: 140.0,
            child: Image.asset(
              _selectedImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
