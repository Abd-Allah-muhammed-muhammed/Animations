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
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        title: Text(
          'Toggle Container Animation',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: _toggleExpanded,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: _isExpanded ? 600 : 200,
              decoration: BoxDecoration(
                color: Colors.pink[400],

              ),
              child: Center(
                child: Text(
                  _isExpanded ? 'Tap me to collapse' : 'Tap me to expand',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
