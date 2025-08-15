import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../models/media_model.dart';
import '../utils/constants.dart';
import 'second_level_screen.dart';

class SecondLevelPage extends StatefulWidget {
  final int level;

  SecondLevelPage({required this.level});

  @override
  _SecondLevelPageState createState() => _SecondLevelPageState();
}

class _SecondLevelPageState extends State<SecondLevelPage> {
  final AudioService _audioService = AudioService();
  late String _selectedImage;
  late String _correctNumber;

  @override
  void initState() {
    super.initState();
    _selectRandomMedia();
    _playAudio();

    Timer(AppConstants.splashDuration, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondLevelScreen(
            correctNumber: _correctNumber,
            level: widget.level + 1,
          ),
        ),
      );
    });
  }

  void _selectRandomMedia() {
    final random = Random();
    final randomIndex = random.nextInt(MediaData.mediaList.length);
    final selectedMedia = MediaData.mediaList[randomIndex];

    _selectedImage = selectedMedia.image;
    _correctNumber = selectedMedia.number;
  }

  void _playAudio() {
    final selectedMedia = MediaData.mediaList.firstWhere(
      (media) => media.number == _correctNumber,
    );
    if (selectedMedia.audio != null) {
      _audioService.playAudio(selectedMedia.audio!);
    }
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
