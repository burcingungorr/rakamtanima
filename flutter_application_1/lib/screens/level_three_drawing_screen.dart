import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:image_picker/image_picker.dart';
import '../services/audio_service.dart';
import '../services/ml_service.dart';
import '../widgets/navigation_buttons.dart';
import '../widgets/signature_canvas.dart';
import '../utils/constants.dart';
import 'level_selection_screen.dart';
import 'third_level_page.dart';

class LevelThreeDrawingScreen extends StatefulWidget {
  final String correctNumber;
  final int level;

  LevelThreeDrawingScreen({required this.correctNumber, required this.level});

  @override
  _LevelThreeDrawingScreenState createState() =>
      _LevelThreeDrawingScreenState();
}

class _LevelThreeDrawingScreenState extends State<LevelThreeDrawingScreen> {
  int _timeLeft = 5;
  late Timer _timer;
  late SignatureController _controller;
  final MLService _mlService = MLService();
  final AudioService _audioService = AudioService();
  final GlobalKey _signatureKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();

  String _prediction = '';
  Uint8List? _selectedImage;
  Widget _icon = SizedBox.shrink();
  int _currentLevel = 1;
  String _currentCorrectNumber = '';

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: AppConstants.penStrokeWidth,
      penColor: AppConstants.textColor,
      exportBackgroundColor: AppConstants.backgroundColor,
    );
    _mlService.loadModel();
    _startCountdown();
    _currentCorrectNumber = widget.correctNumber;
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          timer.cancel();
          _predictDigit();
        }
      });
    });
  }

  Future<void> _predictDigit() async {
    if (!_mlService.isModelLoaded) {
      setState(() {
        _icon = SizedBox.shrink();
      });
      return;
    }

    String prediction = await _mlService.predictDigit(_signatureKey,
        selectedImage: _selectedImage);

    setState(() {
      _prediction = prediction;
    });

    if (_prediction == _currentCorrectNumber) {
      setState(() {
        _icon =
            Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 50);
      });
      await _audioService.playAudio(AudioFiles.congratulations);
      await Future.delayed(AppConstants.audioDelay);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ThirdLevelPage(level: _currentLevel)),
      );
    } else {
      setState(() {
        _icon = Icon(Icons.sentiment_very_dissatisfied,
            color: Colors.red, size: 50);
      });
      await _audioService.playAudio(AudioFiles.tryAgain);
      await Future.delayed(AppConstants.audioDelay);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LevelSelectionScreen()),
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _selectedImage = imageBytes;
        _prediction = '';
        _icon = SizedBox.shrink();
      });
      _predictDigit();
    }
  }

  void _clearCanvas() {
    setState(() {
      _controller.clear();
      _selectedImage = null;
      _prediction = '';
      _icon = SizedBox.shrink();
    });
  }

  void _navigateBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LevelSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            '$_timeLeft',
            style: TextStyle(fontSize: 48, color: Colors.white),
          ),
          SizedBox(height: 20),
          NavigationButtons(
            onBack: _navigateBack,
            onClear: _clearCanvas,
            showDone: false,
          ),
          if (_selectedImage == null)
            SignatureCanvas(
              controller: _controller,
              signatureKey: _signatureKey,
            )
          else
            Expanded(
              child: Image.memory(_selectedImage!),
            ),
          SizedBox(height: 20),
          _icon,
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppConstants.primaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_library, color: Colors.white),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }
}
