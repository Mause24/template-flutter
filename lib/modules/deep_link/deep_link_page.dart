import 'package:flutter/material.dart';

class DeepLinkPage extends StatelessWidget {
  final String id;

  const DeepLinkPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deep Linking')),
      body: Center(child: Text('ID recibido: $id')),
    );
  }
}
