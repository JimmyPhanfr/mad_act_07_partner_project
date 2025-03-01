import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: PageView(
        children: [
          FadingTextAnimation(
            onThemeToggle: toggleTheme,
            isDarkMode: _isDarkMode,
            animationType: AnimationType.fade,
          ),
          FadingTextAnimation(
            onThemeToggle: toggleTheme,
            isDarkMode: _isDarkMode,
            animationType: AnimationType.scale,
          ),
        ],
      ),
    );
  }
}

enum AnimationType { fade, scale }

class FadingTextAnimation extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final bool isDarkMode;
  final AnimationType animationType;

  const FadingTextAnimation({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
    required this.animationType,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.black;
  bool _isScaleAnimation = false;
  double borderRadiusValue = 50.0;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void changeTextColor(Color color) {
    setState(() {
      _textColor = color;
    });
  }

  void toggleTextAnimation() {
    setState(() {
      if (widget.animationType == AnimationType.fade) {
        _isVisible = !_isVisible;
      } else {
        _isScaleAnimation = !_isScaleAnimation;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.onThemeToggle,
          ),
        ],
      ),
        body: Center(
        child: widget.animationType == AnimationType.scale
            ? AnimatedScale(
                scale: _isScaleAnimation ? 1.5 : 1.0,
                duration: Duration(seconds: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, Flutter!',
                      style: TextStyle(fontSize: 24, color: _textColor),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadiusValue),
                        child: Image.asset(
                          'assets/images/pikachu.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (borderRadiusValue == 50) {
                            borderRadiusValue = 0;
                          } else { borderRadiusValue = 50; }
                        });
                      },
                      child: const Text('Border Radius Button')
                    ),
                  ],
                ),
              )
            : AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, Flutter!',
                      style: TextStyle(fontSize: 24, color: _textColor),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadiusValue),
                        child: Image.asset(
                          'assets/images/pikachu.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (borderRadiusValue == 50) {
                            borderRadiusValue = 0;
                          } else { borderRadiusValue = 50; }
                        });
                      },
                      child: const Text('Border Radius Button')
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: toggleTextAnimation,
              child: Icon(Icons.play_arrow),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Pick Text Color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: _textColor,
                        onColorChanged: (color) {
                          changeTextColor(color);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                );
              },
              child: Icon(Icons.palette),
            ),
          ),
        ],
      ),
    );
  }
}
