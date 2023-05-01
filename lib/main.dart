import 'package:flutter/material.dart';



void main() {
  runApp(
    MyApp(),

  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnimatedContainer Example',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      home: MyWidget(),
    );
  }
}



class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool _isFadedIn = false;

  void _toggleFadeIn() {
    setState(() {
      _isFadedIn = !_isFadedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor:   Colors.purple[400],
        title: Text(
          'Fade-in Animation',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: GestureDetector(
        onTap: _toggleFadeIn,
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple[400]!,
                  Colors.pink[400]!,
                  Colors.orange[400]!,
                ],
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: _isFadedIn ? 1 : 0,
              child: Center(
                child: Text(
                  'Tap me to fade in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
