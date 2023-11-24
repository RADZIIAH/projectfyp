import 'package:flutter/material.dart';

void main() {
  runApp(AnimatedAdvertisement());
}

class AnimatedAdvertisement extends StatefulWidget {
  @override
  _AnimatedAdvertisementState createState() => _AnimatedAdvertisementState();
}

class _AnimatedAdvertisementState extends State<AnimatedAdvertisement>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated Advertisement'),
        ),
        body: Center(
          child: SlideTransition(
            position: _animation,
            child: Container(
              width: 200,
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Your Advertisement',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
