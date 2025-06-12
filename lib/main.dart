import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<QuranAPI> fetchAyah() async {
  String url = 'https://api.alquran.cloud/v1/ayah/114:1/id.muntakhab';
  final response = await http.get(
    Uri.parse(url),
  );
  
  if (response.statusCode == 200) {
    print(response.statusCode);
    return QuranAPI.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    print(response.statusCode);
    throw Exception('Failed to fetch Ayah.');
  }
}

class AyahData {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final bool sajda;

  const AyahData({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda
  });

  factory AyahData.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'number': int number,
      'text': String text,
      'numberInSurah': int numberInSurah,
      'juz': int juz,
      'manzil': int manzil,
      'page': int page,
      'ruku': int ruku,
      'hizbQuarter': int hizbQuarter,
      'sajda': bool sajda
      } =>
          AyahData(
              number: number,
              text: text,
              numberInSurah: numberInSurah,
              juz: juz,
              manzil: manzil,
              page: page,
              ruku: ruku,
              hizbQuarter: hizbQuarter,
              sajda: sajda
          ),
      _ => throw const FormatException('Failed to load ayah.'),
    };
  }
}

class QuranAPI {
  final int code;
  final String status;
  final AyahData data;

  const QuranAPI(
  {
    required this.code,
    required this.status,
    required this.data
  });

  factory QuranAPI.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'code': int code,
        'status': String status,
        'data': AyahData data
      } => QuranAPI(
          code: code,
          status: status,
          data: data
      ),
      _ => throw const FormatException('Failed to load QuranAPI.'),
    };
  }
}

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
  String _currentFortune = ':)';
  late Future<QuranAPI> futureAyah;

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
  void initState() {
    super.initState();
    futureAyah = fetchAyah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: <Widget>[
            Image.asset("asset/image/fortune_cookie.png", width: 200, height: 200, fit: BoxFit.cover,),
            Card(
              child: FutureBuilder<QuranAPI>(
                builder: (context, key) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      key.data!.data.text,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                }, future: null,
              ),
            ),
            ElevatedButton(onPressed: _randomFortune, child: Text('Click for fortune',),)
          ],
        ),
      ),
    );
  }
}
