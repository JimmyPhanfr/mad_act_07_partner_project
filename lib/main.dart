import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
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
      home: FadingTextAnimation(onThemeToggle: toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final bool isDarkMode;

  const FadingTextAnimation({Key? key, required this.onThemeToggle, required this.isDarkMode}) : super(key: key);

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.black;

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
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24, color: _textColor),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: toggleVisibility,
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
