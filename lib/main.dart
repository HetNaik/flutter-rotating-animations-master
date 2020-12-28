import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vector_math/vector_math_64.dart';
//import 'package:vector_math/vector_math.dart';
//import 'package:vector_math/vector_math.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SizedBox.expand(child: RadialMenu()),
    ));
  }
}

class RadialMenu extends StatefulWidget {
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> scale, translation;
  RadialAnimation({Key key, this.controller})
      : scale = Tween<double>(begin: 1.5, end: 0.0).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        translation = Tween<double>(begin: 0, end: 100).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.linearToEaseOut,
        )),
        super(key: key);

  build(context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {
          return Stack(
            alignment: Alignment.center,
            children: [
              _buildButton(0,icon: FontAwesomeIcons.thumbtack,),
              _buildButton(45,icon: FontAwesomeIcons.sprayCan,),
              _buildButton(90,icon: FontAwesomeIcons.fire,),
              _buildButton(135,icon: FontAwesomeIcons.kiwiBird,),
              _buildButton(180,icon: FontAwesomeIcons.cat,),
              _buildButton(225,icon: FontAwesomeIcons.paw,),
              _buildButton(270,icon: FontAwesomeIcons.bong,),
              _buildButton(315,icon: FontAwesomeIcons.bolt,),
              
              Transform.scale(
                  scale: scale.value - 1,
                  child: FloatingActionButton(
                    onPressed: _close,
                    //backgroundColor: Colors.red,
                    child: Icon(FontAwesomeIcons.timesCircle),
                  )),
              Transform.scale(
                  scale: scale.value,
                  child: FloatingActionButton(
                    onPressed: _open,
                    //backgroundColor: Colors.blue,
                    child: Icon(FontAwesomeIcons.solidDotCircle),
                  )),
            ],
          );
        });
  }

  _buildButton(double angle, {Color color, IconData icon}) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
              child: FloatingActionButton(onPressed: _close,backgroundColor: color,child: Icon(icon),),
              );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
