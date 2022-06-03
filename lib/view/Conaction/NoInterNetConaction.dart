import 'package:flutter/material.dart';

class NoConcation extends StatefulWidget {
  @override
  State<NoConcation> createState() => _NoConcationState();
}

class _NoConcationState extends State<NoConcation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Text("NoInternetConcation"),
      ),
    );
  }
}
