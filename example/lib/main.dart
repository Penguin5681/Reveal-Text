import 'package:flutter/material.dart';
import 'package:reveal_text/reveal_text.dart';

/// The main function is the entry point of the Flutter application.
void main() {
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  /// Creates an instance of [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/// The home page of the application.
class MyHomePage extends StatefulWidget {
  /// Creates an instance of [MyHomePage].
  const MyHomePage({super.key, required this.title});

  /// The title of the home page.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// The state for the home page widget.
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: RevealText(
          text: 'Character Animation',
          animateBy: AnimationType.letters,
          delay: Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
