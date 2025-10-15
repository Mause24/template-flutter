import 'package:flutter/material.dart';

class CustomScreen extends StatefulWidget {
  const CustomScreen({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: widget.child,
    );
  }
}
