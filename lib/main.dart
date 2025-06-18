import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<AyahResponse> fetchAyahResponse() async {
  String url = 'https://api.alquran.cloud/v1/ayah/114:2/id.muntakhab';
  final response = await http.get(
    Uri.parse(url),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return AyahResponse.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception('Failed to fetch AyahResponse.');
  }
}

class Edition {
  final String identifier;
  final String language;
  final String name;
  final String englishName;
  final String format;
  final String type;
  final String direction;

  Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    required this.direction,
  });

  factory Edition.fromJson(Map<String, dynamic> json) => Edition(
        identifier: json['identifier'],
        language: json['language'],
        name: json['name'],
        englishName: json['englishName'],
        format: json['format'],
        type: json['type'],
        direction: json['direction'],
      );
}

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json['number'],
        name: json['name'],
        englishName: json['englishName'],
        englishNameTranslation: json['englishNameTranslation'],
        numberOfAyahs: json['numberOfAyahs'],
        revelationType: json['revelationType'],
      );
}

class AyahData {
  final int number;
  final String text;
  final Edition edition;
  final Surah surah;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final bool sajda;

  AyahData({
    required this.number,
    required this.text,
    required this.edition,
    required this.surah,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory AyahData.fromJson(Map<String, dynamic> json) => AyahData(
        number: json['number'],
        text: json['text'],
        edition: Edition.fromJson(json['edition']),
        surah: Surah.fromJson(json['surah']),
        numberInSurah: json['numberInSurah'],
        juz: json['juz'],
        manzil: json['manzil'],
        page: json['page'],
        ruku: json['ruku'],
        hizbQuarter: json['hizbQuarter'],
        sajda: json['sajda'],
      );
}

class AyahResponse {
  final int code;
  final String status;
  final AyahData data;

  AyahResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory AyahResponse.fromJson(Map<String, dynamic> json) => AyahResponse(
        code: json['code'],
        status: json['status'],
        data: AyahData.fromJson(json['data']),
      );
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
  const MyHomePage({super.key});

  // This widget is the home page of your application.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<AyahResponse> ayahText;

  @override
  void initState() {
    super.initState();
    ayahText = fetchAyahResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: <Widget>[
              Image.asset(
                "asset/image/quranVector.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              FutureBuilder<AyahResponse>(
                  future: ayahText,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      return Card(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          snapshot.data!.data.text,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ));
                    } else {
                      return const Center(
                        child: Text('No data'),
                      );
                    }
                  }),
              ElevatedButton(
                onPressed: () async {
                  await fetchAyahResponse();
                },
                child: Text(
                  'Read',
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
