import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Islamic Rosary Beads'),
        ),
        body: RosaryBeads(),
      ),
    );
  }
}

class RosaryBeads extends StatefulWidget {
  @override
  _RosaryBeadsState createState() => _RosaryBeadsState();
}

class _RosaryBeadsState extends State<RosaryBeads> with TickerProviderStateMixin {
  int clickedIndex = 0;


  void _handleBeadTap(int index) {

    print(clickedIndex);
    if (clickedIndex ==33) {

      clickedIndex = 0;
    }else{
      clickedIndex++;
    }
    setState(() {


    });
  }

  double getBeadSize(int index) {

    if (index == 0) {

      return 80.0;

    }  else {

      return index == clickedIndex ? 60.0 : 40.0; // Adjust bead size as needed

    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(

        duration: Duration(milliseconds: 400),
        child: Stack(
          children: List.generate(34, (index) {
            final double angle = 2 * pi / 36 * index;
            final double centerX = 250.0; // Adjust the center X coordinate
            final double centerY = 250.0; // Adjust the center Y coordinate
            final double radius = 150.0; // Adjust the radius

            final double x = centerX + radius * cos(angle);
            final double y = centerY + radius * sin(angle);

            if (index==0) {

              return Positioned(
                left: x - 30, // 30 is half of the bead size
                top: y - 60, // 30 is half of the bead size
                child: GestureDetector(
                  onTap: () => _handleBeadTap(index),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: getBeadSize(index),
                    height: getBeadSize(index),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,

                    ),
                  ),
                ),
              );
            }  else {
              return Positioned(
                left: x - 10, // 30 is half of the bead size
                top: y - 30, // 30 is half of the bead size
                child: GestureDetector(
                  onTap: () => _handleBeadTap(index),
                  child: AnimatedContainer(
                  transformAlignment: Alignment.bottomCenter,
                    duration: Duration(milliseconds: 400,),
                    width: getBeadSize(index),
                    height: getBeadSize(index),
                    decoration: BoxDecoration(
                      color: index == clickedIndex ? Colors.blue : Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (index).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }}),
        ),
      ),
    );
  }
}
