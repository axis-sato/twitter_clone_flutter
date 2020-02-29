import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: SizedBox(
            width: 33,
            height: 33,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
