import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
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

class _RosaryBeadsState extends State<RosaryBeads>
    with TickerProviderStateMixin {
  int clickedIndex = 0;

  void _handleBeadTap(int index) async{
    print(clickedIndex);
    playSong().then((value) {

      if (index==0) {

        _startAnimation();
      }
      if (clickedIndex == 33) {
        clickedIndex = 0;
      } else {
        clickedIndex++;
      }

      setState(() {});
    });


  }

  double getBeadSize(int index) {
    if (index == 0) {
      return index == clickedIndex ? 70.0 : 80.0; // Adjust bead size as needed
    } else {
      return index == clickedIndex ? 70.0 : 40.0; // Adjust bead size as needed
    }
  }

  late AnimationController _animationController;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds : 40));
    _animation =
        Tween<double>(begin: 0 , end: 1 * pi).animate(_animationController);
  }


  Future<void> playSong() async {

    final player = AudioPlayer();
    return await player.play(AssetSource('play.wav'));

  }

  void _startAnimation() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.black,
      child: Center(
        child: Stack(
          children: List.generate(34, (index) {
            final double angle = 2 * pi / 36 * index;
            final double centerX = 500.0; // Adjust the center X coordinate
            final double centerY = 500.0; // Adjust the center Y coordinate
            final double radius = 250.0; // Adjust the radius

            final double x = centerX + radius * cos(angle);
            final double y = centerY + radius * sin(angle);



              return Positioned(

                left: index == 0?  x - 60 : x - 40,
                top: index == 0 ? y - 65 : y - 20,
                child: GestureDetector(
                  onHorizontalDragDown: (de) async => _handleBeadTap(index),
                  child: RotationTransition(
                    turns: _animation,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      transformAlignment: Alignment.bottomCenter,

                      width: getBeadSize(index),
                      height: getBeadSize(index),
                      decoration: BoxDecoration(
                        color: index == clickedIndex ? Colors.blue : Colors.green,
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.amber, Colors.amberAccent],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey ,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2), // shadow offset
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 10,
                            decoration: BoxDecoration(
                                color: index == clickedIndex
                                    ? Colors.blue
                                    : Colors.green,
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.green],
                                ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2), // shadow offset
                                ),
                              ],
                            ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

          }),
        ),
      ),
    );
  }
}
