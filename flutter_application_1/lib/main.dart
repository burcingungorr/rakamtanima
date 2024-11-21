import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:signature/signature.dart';
import 'package:flutter/rendering.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rakam Çiz',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SecondPage()),
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
            top: 30,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  _buildTitle("Rakam"),
                  _buildTitle("Çiz"),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: Image.asset(
              'assets/1.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 70,
        color: Colors.orange,
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
    );
  }
}





class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isHovered = false;
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playAudio('seviyenisec.mp3');
  }

  Future<void> _playAudio(String audioFile) async {
    try {
      await _audioPlayer.play(AssetSource('$audioFile'));

    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _onTap(int index) async{
    if (index == 3) {
     await _playAudio('surebitmeden.mp3');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ThirdLevelPage(level: 3)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          if (index == 1) {
            return FirstLevelPage(level: 1);
          } else if (index == 2) {
            return SecondLevelPage(level: 2);
          } else if (index == 4) {
            return LevelFourthDrawingScreen(level: 4);
          } else {
            return SecondPage(); 
          }
        }),
      );
    }
  }

  Widget _buildTextContainer(String text, int index) {
    return GestureDetector(
      onTap: () => _onTap(index),
      child: Container(
        width: 120,
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: const ui.Color.fromARGB(255, 255, 255, 255), width: 3,),
           color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: const ui.Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
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
                      _buildTextContainer('1', 1),
                      SizedBox(width: 20),
                      _buildTextContainer('2', 2),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTextContainer('3', 3),
                      SizedBox(width: 20),
                      _buildTextContainer('4', 4),
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
                      color: Colors.orange,
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
                      color: Colors.orange,
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




class FirstLevelPage extends StatefulWidget {
  final int level;

  FirstLevelPage({Key? key, required this.level}) : super(key: key);

  @override
  _FirstLevelPageState createState() => _FirstLevelPageState();
}

class _FirstLevelPageState extends State<FirstLevelPage> {
  late AudioPlayer _audioPlayer;
  late String _selectedImage;
  late AssetSource _selectedAudio;
  late String _correctNumber;

  final List<Map<String, String>> _mediaList = [
    {'image': 'assets/sifir.jpg', 'audio': 'sifir.mp3', 'number': '0'},
    {'image': 'assets/bir.jpg', 'audio': 'bir.mp3', 'number': '1'},
    {'image': 'assets/iki.jpg', 'audio': 'iki.mp3', 'number': '2'},
    {'image': 'assets/uc.jpg', 'audio': 'uc.mp3', 'number': '3'},
    {'image': 'assets/dort.jpg', 'audio': 'dort.mp3', 'number': '4'},
    {'image': 'assets/bes.jpg', 'audio': 'bes.mp3', 'number': '5'},
    {'image': 'assets/alti.jpg', 'audio': 'alti.mp3', 'number': '6'},
    {'image': 'assets/yedi.jpg', 'audio': 'yedi.mp3', 'number': '7'},
    {'image': 'assets/sekiz.jpg', 'audio': 'sekiz.mp3', 'number': '8'},
    {'image': 'assets/dokuz.jpg', 'audio': 'dokuz.mp3', 'number': '9'},
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _startLevel();
  }

 void _startLevel() {
  int levelIndex = widget.level - 1;
  
  // Check if levelIndex is out of bounds
  if (levelIndex >= _mediaList.length) {
    levelIndex = levelIndex % _mediaList.length; // Wrap around using modulo
  }

  setState(() {
    _selectedImage = _mediaList[levelIndex]['image']!;
    _selectedAudio = AssetSource(_mediaList[levelIndex]['audio']!);
    _correctNumber = _mediaList[levelIndex]['number']!;
  });

  _playAudio();

  Timer(Duration(seconds: 3), () {
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

  void _playAudio() async {
    try {
      await _audioPlayer.play(_selectedAudio);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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


class SecondLevelPage extends StatefulWidget {
  final int level;

  SecondLevelPage({required this.level});

  @override
  _SecondLevelPageState createState() => _SecondLevelPageState();
}

class _SecondLevelPageState extends State<SecondLevelPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late String _selectedImage;
  late AssetSource _selectedAudio;
  late String _correctNumber;

  final List<Map<String, String>> _mediaList = [
    {'image': 'assets/sifir.jpg', 'audio': 'sifir.mp3', 'number': '0'},
    {'image': 'assets/bir.jpg', 'audio': 'bir.mp3', 'number': '1'},
    {'image': 'assets/iki.jpg', 'audio': 'iki.mp3', 'number': '2'},
    {'image': 'assets/uc.jpg', 'audio': 'uc.mp3', 'number': '3'},
    {'image': 'assets/dort.jpg', 'audio': 'dort.mp3', 'number': '4'},
    {'image': 'assets/bes.jpg', 'audio': 'bes.mp3', 'number': '5'},
    {'image': 'assets/alti.jpg', 'audio': 'alti.mp3', 'number': '6'},
    {'image': 'assets/yedi.jpg', 'audio': 'yedi.mp3', 'number': '7'},
    {'image': 'assets/sekiz.jpg', 'audio': 'sekiz.mp3', 'number': '8'},
    {'image': 'assets/dokuz.jpg', 'audio': 'dokuz.mp3', 'number': '9'},
  ];

  @override
  void initState() {
    super.initState();
    _selectRandomMedia();
    _playAudio();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondLevelScreen(correctNumber: _correctNumber, level: widget.level + 1),
        ),
      );
    });
  }

  void _selectRandomMedia() {
    final random = Random();
    final randomIndex = random.nextInt(_mediaList.length);
    _selectedImage = _mediaList[randomIndex]['image']!;
    _selectedAudio = AssetSource(_mediaList[randomIndex]['audio']!);
    _correctNumber = _mediaList[randomIndex]['number']!;
  }

  void _playAudio() async {
    try {
      await _audioPlayer.play(_selectedAudio);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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
class ThirdLevelPage extends StatefulWidget {
  final int level;

  ThirdLevelPage({required this.level});

  @override
  _ThirdLevelPageState createState() => _ThirdLevelPageState();
}

class _ThirdLevelPageState extends State<ThirdLevelPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late String _selectedImage;
  late AssetSource _selectedAudio;
  late String _correctNumber;

  final List<Map<String, String>> _mediaList = [
    {'image': 'assets/sifir.jpg',  'number': '0'},
    {'image': 'assets/bir.jpg', 'number': '1'},
    {'image': 'assets/iki.jpg',  'number': '2'},
    {'image': 'assets/uc.jpg',  'number': '3'},
    {'image': 'assets/dort.jpg',  'number': '4'},
    {'image': 'assets/bes.jpg',  'number': '5'},
    {'image': 'assets/alti.jpg', 'number': '6'},
    {'image': 'assets/yedi.jpg',  'number': '7'},
    {'image': 'assets/sekiz.jpg',  'number': '8'},
    {'image': 'assets/dokuz.jpg', 'number': '9'},
  ];

  @override
  void initState() {
    super.initState();
    _selectRandomMedia();
    _playAudio();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LevelThreeDrawingScreen(correctNumber: _correctNumber, level: widget.level + 1),
        ),
      );
    });
  }

  void _selectRandomMedia() {
    final random = Random();
    final randomIndex = random.nextInt(_mediaList.length);
    _selectedImage = _mediaList[randomIndex]['image']!;
    _correctNumber = _mediaList[randomIndex]['number']!;
  }

  void _playAudio() async {
    try {
      await _audioPlayer.play(_selectedAudio);
    } catch (e) {
            print('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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

class FirstLevelScreen extends StatefulWidget {
  final String correctNumber;
  final int level;

  FirstLevelScreen({required this.correctNumber, required this.level});

  @override
  _FirstLevelScreenState createState() => _FirstLevelScreenState();
}

class _FirstLevelScreenState extends State<FirstLevelScreen> {
  late SignatureController _controller;
  Interpreter? _interpreter;
  String _prediction = '';
  bool _isModelLoaded = false;
  final GlobalKey _signatureKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _selectedImage;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Widget _icon = SizedBox.shrink(); // Placeholder for the icon

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 30,
      penColor: Colors.white,
      exportBackgroundColor: Colors.black,
    );
    loadModel();
  }

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/mnist.tflite');
    setState(() {
      _isModelLoaded = true;
    });
  }

  Future<void> predictDigit() async {
    if (!_isModelLoaded) {
      setState(() {
        _icon = SizedBox.shrink(); // No icon to show
      });
      return;
    }

    if (_selectedImage == null) {
      RenderRepaintBoundary boundary = _signatureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        print('Byte data is null');
        return;
      }

      _selectedImage = byteData.buffer.asUint8List();
    }

    img.Image originalImage = img.decodeImage(_selectedImage!)!;
    img.Image resizedImage = img.copyResize(originalImage, width: 28, height: 28);
    resizedImage = img.grayscale(resizedImage);

    var input = Float32List(1 * 28 * 28 * 1);
    var buffer = Float32List.view(input.buffer);
    for (int i = 0; i < 28 * 28; i++) {
      int x = i % 28;
      int y = i ~/ 28;
      var pixel = resizedImage.getPixel(x, y);
      double grayscale = img.getLuminance(pixel) / 255.0;
      buffer[i] = grayscale;
    }

    var output = List.filled(10, 0.0).reshape([1, 10]);

    _interpreter!.run(input.reshape([1, 28, 28, 1]), output);

    var predictedIndex = output[0].indexWhere((element) => element == output[0].reduce((double a, double b) => a > b ? a : b));

    setState(() {
      _prediction = predictedIndex.toString();
    });

    if (_prediction == widget.correctNumber) {
      setState(() {
        _icon = Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 50);
      });
      _playAudio('tebrikler.mp3');
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FirstLevelPage(level: widget.level + 1)),
        );
      });
    } else {
      setState(() {
        _icon = Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 50);
      });
      _playAudio('tekrardenemelisin.mp3');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _selectedImage = imageBytes;
        _prediction = '';
        _icon = SizedBox.shrink();
      });
      predictDigit();
    }
  }

  Future<void> _playAudio(String audioPath) async {
    try {
      await _audioPlayer.play(AssetSource(audioPath));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 60), 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
                    );
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: predictDigit,
                  child: Icon(Icons.done, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      _selectedImage = null;
                      _prediction = '';
                    });
                  },
                  child: Icon(Icons.clear, color: Colors.white),
                ),
              ],
            ),
          ),
          if (_selectedImage == null)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: RepaintBoundary(
                  key: _signatureKey,
                  child: Signature(
                    controller: _controller,
                    height: MediaQuery.of(context).size.height,
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: Image.memory(_selectedImage!),
            ),
          SizedBox(height: 20),
         
          SizedBox(height: 20),
          _icon, // Display the icon
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_library, color: Colors.white),
                onPressed: () => pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () => pickImage(ImageSource.camera),
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
    _interpreter?.close();
    _audioPlayer.dispose();
    super.dispose();
  }
}


class SecondLevelScreen extends StatefulWidget {
  final String correctNumber;
  final int level;

  SecondLevelScreen({required this.correctNumber, required this.level});

  @override
  _SecondLevelScreenState createState() => _SecondLevelScreenState();
}

class _SecondLevelScreenState extends State<SecondLevelScreen> {
  late SignatureController _controller;
  Interpreter? _interpreter;
  String _prediction = '';
  bool _isModelLoaded = false;
  final GlobalKey _signatureKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _selectedImage;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Widget _icon = SizedBox.shrink(); // Placeholder for the icon

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 30,
      penColor: Colors.white,
      exportBackgroundColor: Colors.black,
    );
    loadModel();
  }

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/mnist.tflite');
    setState(() {
      _isModelLoaded = true;
    });
  }

  Future<void> predictDigit() async {
    if (!_isModelLoaded) {
      setState(() {
        _icon = SizedBox.shrink(); // No icon to show
      });
      return;
    }

    if (_selectedImage == null) {
      RenderRepaintBoundary boundary = _signatureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        print('Byte data is null');
        return;
      }

      _selectedImage = byteData.buffer.asUint8List();
    }

    img.Image originalImage = img.decodeImage(_selectedImage!)!;
    img.Image resizedImage = img.copyResize(originalImage, width: 28, height: 28);
    resizedImage = img.grayscale(resizedImage);

    var input = Float32List(1 * 28 * 28 * 1);
    var buffer = Float32List.view(input.buffer);
    for (int i = 0; i < 28 * 28; i++) {
      int x = i % 28;
      int y = i ~/ 28;
      var pixel = resizedImage.getPixel(x, y);
      double grayscale = img.getLuminance(pixel) / 255.0;
      buffer[i] = grayscale;
    }

    var output = List.filled(10, 0.0).reshape([1, 10]);

    _interpreter!.run(input.reshape([1, 28, 28, 1]), output);

    var predictedIndex = output[0].indexWhere((element) => element == output[0].reduce((double a, double b) => a > b ? a : b));

    setState(() {
      _prediction = predictedIndex.toString();
    });

    if (_prediction == widget.correctNumber) {
      setState(() {
        _icon = Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 50);
      });
      _playAudio('tebrikler.mp3');
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SecondLevelPage(level: widget.level + 1)),
        );
      });
    } else {
      setState(() {
        _icon = Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 50);
      });
      _playAudio('tekrardenemelisin.mp3');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _selectedImage = imageBytes;
        _prediction = '';
        _icon = SizedBox.shrink();
      });
      predictDigit();
    }
  }

  Future<void> _playAudio(String audioPath) async {
    try {
      await _audioPlayer.play(AssetSource(audioPath));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 60), 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
                    );
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: predictDigit,
                  child: Icon(Icons.done, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      _selectedImage = null;
                      _prediction = '';
                    });
                  },
                  child: Icon(Icons.clear, color: Colors.white),
                ),
              ],
            ),
          ),
          if (_selectedImage == null)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: RepaintBoundary(
                  key: _signatureKey,
                  child: Signature(
                    controller: _controller,
                    height: MediaQuery.of(context).size.height,
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: Image.memory(_selectedImage!),
            ),
          SizedBox(height: 20),
          
          SizedBox(height: 20),
          _icon, // Display the icon
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_library, color: Colors.white),
                onPressed: () => pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () => pickImage(ImageSource.camera),
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
    _interpreter?.close();
    _audioPlayer.dispose();
    super.dispose();
  }
}





class LevelThreeDrawingScreen extends StatefulWidget {
  final String correctNumber;
  final int level;

  LevelThreeDrawingScreen({required this.correctNumber, required this.level});

  @override
  _LevelThreeDrawingScreenState createState() => _LevelThreeDrawingScreenState();
}

class _LevelThreeDrawingScreenState extends State<LevelThreeDrawingScreen> {
  int _timeLeft = 5;
  late Timer _timer;
  late SignatureController _controller;
  Interpreter? _interpreter;
  String _prediction = '';
  bool _isModelLoaded = false;
  final GlobalKey _signatureKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _selectedImage;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Widget _icon = SizedBox.shrink(); // Placeholder for the icon
  int _currentLevel = 1;
  String _currentCorrectNumber = ''; // Track the current correct number

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 30,
      penColor: Colors.white,
      exportBackgroundColor: Colors.black,
    );
    loadModel();
    _startCountdown();
    _currentCorrectNumber = widget.correctNumber; // Initialize with initial correct number
  }

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/mnist.tflite');
    setState(() {
      _isModelLoaded = true;
    });
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          timer.cancel();
          predictDigit();
        }
      });
    });
  }

  Future<void> predictDigit() async {
    if (!_isModelLoaded) {
      setState(() {
        _icon = SizedBox.shrink(); 
      });
      return;
    }

    if (_selectedImage == null) {
      RenderRepaintBoundary boundary = _signatureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        print('Byte data is null');
        return;
      }

      _selectedImage = byteData.buffer.asUint8List();
    }

    img.Image originalImage = img.decodeImage(_selectedImage!)!;
    img.Image resizedImage = img.copyResize(originalImage, width: 28, height: 28);
    resizedImage = img.grayscale(resizedImage);

    var input = Float32List(1 * 28 * 28 * 1);
    var buffer = Float32List.view(input.buffer);
    for (int i = 0; i < 28 * 28; i++) {
      int x = i % 28;
      int y = i ~/ 28;
      var pixel = resizedImage.getPixel(x, y);
      double grayscale = img.getLuminance(pixel) / 255.0;
      buffer[i] = grayscale;
    }

    var output = List.filled(10, 0.0).reshape([1, 10]);

    _interpreter!.run(input.reshape([1, 28, 28, 1]), output);

    var predictedIndex = output[0].indexWhere((element) => element == output[0].reduce((double a, double b) => a > b ? a : b));

    setState(() {
      _prediction = predictedIndex.toString();
    });

   if (_prediction == _currentCorrectNumber) {
  setState(() {
    _icon = Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 50);
  });
  await _playAudio('tebrikler.mp3');
  await Future.delayed(Duration(seconds: 2));
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => ThirdLevelPage(level: _currentLevel)), // Navigate to ThirdLevelPage
  );
} else {
  setState(() {
    _icon = Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 50);
  });
  await _playAudio('tekrardenemelisin.mp3');
  await Future.delayed(Duration(seconds: 2));
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => SecondPage()), // Navigate to SecondPage
  );
}
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _selectedImage = imageBytes;
        _prediction = '';
        _icon = SizedBox.shrink();
      });
      predictDigit();
    }
  }

  Future<void> _playAudio(String audioPath) async {
    try {
      await _audioPlayer.play(AssetSource(audioPath));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
            SizedBox(width: 20), // Add spacing between buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                setState(() {
                  _controller.clear();
                  _selectedImage = null;
                  _prediction = '';
                });
              },
              child: Icon(Icons.clear, color: Colors.white),
            ),
          ],
        ),
        if (_selectedImage == null)
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: RepaintBoundary(
                key: _signatureKey,
                child: Signature(
                  controller: _controller,
                  height: MediaQuery.of(context).size.height,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
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
      color: Colors.orange,
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Container(
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_library, color: Colors.white),
              onPressed: () => pickImage(ImageSource.gallery),
            ),
            IconButton(
              icon: Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () => pickImage(ImageSource.camera),
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
    _interpreter?.close();
    _audioPlayer.dispose();
    _timer.cancel(); // Timer'i dispose ediyoruz.
    super.dispose();
  }
}

class LevelFourthDrawingScreen extends StatefulWidget {
  final int level;

  LevelFourthDrawingScreen({required this.level});

  @override
  _LevelFourthDrawingScreenState createState() => _LevelFourthDrawingScreenState();
}

class _LevelFourthDrawingScreenState extends State<LevelFourthDrawingScreen> {
  late SignatureController _controller;
  Interpreter? _interpreter;
  String _prediction = '';
  bool _isModelLoaded = false;
  final GlobalKey _signatureKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _selectedImage;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      penStrokeWidth: 30,
      penColor: Colors.white,
      exportBackgroundColor: Colors.black,
    );
    loadModel();
    _playAudio('bildikleriniyaz.mp3');
  }

 Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/mnist.tflite');
    setState(() {
      _isModelLoaded = true;
    });
  }

  Future<void> predictDigit() async {
    if (!_isModelLoaded) {
      // Handle model not loaded
      return;
    }

    if (_selectedImage == null) {
      RenderRepaintBoundary boundary = _signatureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        print('Byte data is null');
        return;
      }

      _selectedImage = byteData.buffer.asUint8List();
    }

    img.Image originalImage = img.decodeImage(_selectedImage!)!;
    img.Image resizedImage = img.copyResize(originalImage, width: 28, height: 28);
    resizedImage = img.grayscale(resizedImage);

    var input = Float32List(1 * 28 * 28 * 1);
    var buffer = Float32List.view(input.buffer);
    for (int i = 0; i < 28 * 28; i++) {
      int x = i % 28;
      int y = i ~/ 28;
      var pixel = resizedImage.getPixel(x, y);
      double grayscale = img.getLuminance(pixel) / 255.0;
      buffer[i] = grayscale;
    }

    var output = List.filled(10, 0.0).reshape([1, 10]);

    _interpreter!.run(input.reshape([1, 28, 28, 1]), output);

    var predictedIndex = output[0].indexWhere((element) => element == output[0].reduce((double a, double b) => a > b ? a : b));

    setState(() {
      _prediction = predictedIndex.toString();
    });
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        _selectedImage = imageBytes;
        _prediction = '';
      });
      predictDigit();
    }
  }

  Future<void> _playAudio(String audioPath) async {
    try {
      await _audioPlayer.play(AssetSource(audioPath));
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 60), 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
                    );
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: predictDigit,
                  child: Icon(Icons.done, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      _selectedImage = null;
                      _prediction = '';
                    });
                  },
                  child: Icon(Icons.clear, color: Colors.white),
                ),
              ],
            ),
          ),
          if (_selectedImage == null)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: RepaintBoundary(
                  key: _signatureKey,
                  child: Signature(
                    controller: _controller,
                    height: MediaQuery.of(context).size.height,
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: Image.memory(_selectedImage!),
            ),
          SizedBox(height: 20),
          Text(
            '$_prediction',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_library, color: Colors.white),
                onPressed: () => pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () => pickImage(ImageSource.camera),
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
    _interpreter?.close();
    _audioPlayer.dispose();
    super.dispose();
  }
}