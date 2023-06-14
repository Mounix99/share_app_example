import 'package:flutter/material.dart';
import 'package:share_example/share_service.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    shareHandlerService(context, mounted);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("First Screen")),
      body: const Center(
        child: Text("Something typed here..."),
      ),
    );
  }
}
