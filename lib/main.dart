import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fortune cookies app',
      theme: ThemeData(
        // This is the theme of your application.
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  // This widget is the home page of your application.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentFortune = '';

  final _fortuneList = [
    "A life built on integrity",
    "Your true north is found in upholding your values, even when no one is watching.",
    "The quiet strength of honesty will open doors that cunning cannot",
    "Integrity is not a destination",
    "A clear conscience is a treasure more valuable than gold.",
    "When you act with integrity, you plant seeds of trust that will bloom beautifully.",
    "The path of least resistance often leads away from your truest self; choose integrity instead.",
    "Let your actions speak louder than words, especially when they speak of your character.",
    "In every decision, big or small, let integrity be your guiding star.",
    "The deepest peace comes from knowing you have lived a life of unwavering truth."
  ];

  void _randomFortune() {
    var random = Random();
    int fortune = random.nextInt(_fortuneList.length);
    setState(() {
      _currentFortune = _fortuneList[fortune];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flutter Demo Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your fortune is:',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _currentFortune,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            ElevatedButton(onPressed: _randomFortune, child: Text('Button',),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _randomFortune,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
