import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimeMachine(),
    );
  }
}

class TimeMachine extends StatefulWidget {
  @override
  _TimeMachine createState() => _TimeMachine();
}

class _TimeMachine extends State<TimeMachine>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 3600), vsync: this)
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Align(
        alignment: Alignment.bottomLeft,
        child: TimeStopper(controller: _animationController),
      ),
      Align(
          alignment: Alignment.center,
          child: RotationTransition(
              alignment: Alignment.center,
              turns: _animationController,
              child: GalaxyFitz()))
    ]);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class GalaxyFitz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('galaxy_transparent.png');
  }
}

class TimeStopper extends StatelessWidget {
  final AnimationController controller;

  const TimeStopper({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.isAnimating) {
          controller.stop();
        } else {
          controller.repeat();
        }
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        width: 100,
        height: 100,
      ),
    );
  }
}
