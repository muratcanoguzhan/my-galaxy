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
      home: MyHomePage(),
    );
  }
}

//#region asddfdsg

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

//#endregion

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final Image galaxy = Image.asset('galaxy_transparent.png');
  final Image ufo = Image.asset('ufo.png');
  AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation =
        AnimationController(duration: const Duration(seconds: 5), vsync: this)
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        galaxy,
        AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return ClipPath(
                  clipper: const BeamClipper(),
                  child: Container(
                    height: 1000,
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                            radius: 1.5,
                            colors: [Colors.yellow, Colors.transparent],
                            stops: [0, _animation.value])),
                  ));
            }),
        ufo
      ],
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
