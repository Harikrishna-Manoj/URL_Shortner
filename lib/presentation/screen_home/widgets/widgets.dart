import 'package:flutter/material.dart';

gradiantAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.cyan, Colors.blue, Colors.indigo[700]!],
      )),
    ),
    title: const Text("URL Shortner"),
    centerTitle: true,
  );
}
