import 'package:flutter/material.dart';
import '../widgets/level_button.dart';
import '../services/audio_service.dart';
import '../utils/constants.dart';
import 'first_level_page.dart';
import 'second_level_page.dart';
import 'third_level_page.dart';
import 'level_fourth_drawing_screen.dart';

class LevelSelectionScreen extends StatefulWidget {
  @override
  _LevelSelectionScreenState createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  final AudioService _audioService = AudioService();

  @override
  void initState() {
    super.initState();
    _audioService.playAudio(AudioFiles.levelSelection);
  }

  void _onLevelTap(int level) async {
    if (level == 3) {
      await _audioService.playAudio(AudioFiles.timeUp);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThirdLevelPage(level: 3)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          switch (level) {
            case 1:
              return FirstLevelPage(level: 1);
            case 2:
              return SecondLevelPage(level: 2);
            case 4:
              return LevelFourthDrawingScreen(level: 4);
            default:
              return LevelSelectionScreen();
          }
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LevelButton(
                        text: '1',
                        onTap: () => _onLevelTap(1),
                      ),
                      SizedBox(width: 20),
                      LevelButton(
                        text: '2',
                        onTap: () => _onLevelTap(2),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LevelButton(
                        text: '3',
                        onTap: () => _onLevelTap(3),
                      ),
                      SizedBox(width: 20),
                      LevelButton(
                        text: '4',
                        onTap: () => _onLevelTap(4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  Text(
                    "Seviyeni",
                    style: TextStyle(
                      fontSize: 50,
                      color: AppConstants.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Seç",
                    style: TextStyle(
                      fontSize: 50,
                      color: AppConstants.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.black,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
