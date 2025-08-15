import 'dart:async';
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../models/media_model.dart';
import '../utils/constants.dart';
import 'first_level_screen.dart';

class FirstLevelPage extends StatefulWidget {
  final int level;

  FirstLevelPage({Key? key, required this.level}) : super(key: key);

  @override
  _FirstLevelPageState createState() => _FirstLevelPageState();
}

class _FirstLevelPageState extends State<FirstLevelPage> {
  final AudioService _audioService = AudioService();
  late String _selectedImage;
  late String _correctNumber;

  @override
  void initState() {
    super.initState();
    _startLevel();
  }

  void _startLevel() {
    int levelIndex = widget.level - 1;

    if (levelIndex >= MediaData.mediaList.length) {
      levelIndex = levelIndex % MediaData.mediaList.length;
    }

    final selectedMedia = MediaData.mediaList[levelIndex];

    setState(() {
      _selectedImage = selectedMedia.image;
      _correctNumber = selectedMedia.number;
    });

    if (selectedMedia.audio != null) {
      _audioService.playAudio(selectedMedia.audio!);
    }

    Timer(AppConstants.splashDuration, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FirstLevelScreen(
            correctNumber: _correctNumber,
            level: widget.level,
          ),
        ),
      );
    });
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
