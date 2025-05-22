import 'package:flutter/material.dart';

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

  String _currentFortune = "";

  // This widget is the home page of your application.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final _fortuneList = [
    "A life built on integrity will always stand strong, no matter the winds of change.",
    "Your true north is found in upholding your values, even when no one is watching.",
    "The quiet strength of honesty will open doors that cunning cannot",
    "Integrity is not a destination, but a constant journey of right choices.",
    "A clear conscience is a treasure more valuable than gold.",
    "When you act with integrity, you plant seeds of trust that will bloom beautifully.",
    "The path of least resistance often leads away from your truest self; choose integrity instead.",
    "Let your actions speak louder than words, especially when they speak of your character.",
    "In every decision, big or small, let integrity be your guiding star.",
    "The deepest peace comes from knowing you have lived a life of unwavering truth."
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
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
            ),
            Text(
              '${_fortuneList[_counter % _fortuneList.length]}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
