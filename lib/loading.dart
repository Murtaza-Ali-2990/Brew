import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[900],
        body: SpinKitRotatingCircle(color: Colors.white, size: 100.0));
  }
}
