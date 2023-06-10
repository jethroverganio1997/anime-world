import 'package:flutter/material.dart';

extension Buttons on Widget {
  Widget expanded() {
    return Row(
      children: [
        Expanded(child: this),
      ],
    );
  }
}
