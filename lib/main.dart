import 'package:flutter/material.dart';
import 'package:videoplayerflutter/Src/Screen/VideoPlayerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Video Player',color: Colors.purpleAccent,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: VideoPlayerPage()
    );
  }
}
