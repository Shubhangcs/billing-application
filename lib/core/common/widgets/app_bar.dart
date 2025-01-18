import 'package:flutter/material.dart';

class CustomAppBar{
  PreferredSizeWidget? build(BuildContext context) {
    return AppBar(
        title: Text("Billsoft"),
        leading: Icon(Icons.receipt_long),
      );
  }
}