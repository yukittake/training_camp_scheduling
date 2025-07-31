import 'package:hive_flutter/hive_flutter.dart';
import 'package:training_camp_scheduling/domain/types/camp.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
import 'package:training_camp_scheduling/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(CampAdapter());
  Hive.registerAdapter(BandAdapter());
  await Hive.openBox<Camp>('CampBox');
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: const Color.fromARGB(255, 68, 210, 155),
          seedColor: const Color.fromARGB(255, 148, 212, 187),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
