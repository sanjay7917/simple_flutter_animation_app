import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State < Home > with TickerProviderStateMixin {
  Animation < double > catAnimation;
  AnimationController catController;
  Animation < double > boxAnimation;
  AnimationController boxController;

  initState() {
    super.initState();

    boxController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    boxAnimation = Tween(begin: 0.0, end: pi * 0.7, ).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.linear,
      ),
    );
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.stop();
      } else if (status == AnimationStatus.dismissed) {
        boxController.stop();
      }
    });
    // boxController.reverse();

    catController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    catAnimation = Tween(begin: 70.0, end: -135.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }
  onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.reverse();
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      boxController.forward();
      catController.forward();
    }
  }
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Animation',
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.red[400],
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ), 
        ),
        backgroundColor: Colors.yellow[800],
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
              textLine(),
            ],
          ),
        ),

        onTap: onTap,
      ),
    );
  }
  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }
  Widget buildBox() {
    return Container(
      height: 225.0,
      width: 200.0,
      color: Colors.yellow[800],
    );
  }
  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 9.0,
          width: 100.0,
          color: Colors.red[400],
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: -boxAnimation.value,
          );
        },
      ),
    );
  }
  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 9.0,
          width: 100.0,
          color: Colors.red[400],
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: boxAnimation.value,
          );
        },
      ),
    );
  }
  Widget textLine() {
    return Positioned(
      top: 100.0,
      right: 50.0,
      left: 50.0,
      child: Text(
        'TAP ME',
        style: new TextStyle(
          fontSize: 25.0,
          color: Colors.red[400],
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}