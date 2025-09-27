import 'package:training_camp_scheduling/infrastructure/hive_classes/hive_band.dart';
import 'package:training_camp_scheduling/infrastructure/hive_classes/hive_camp.dart';
import 'package:training_camp_scheduling/presentation/pages/garbage_page.dart';
import 'package:training_camp_scheduling/presentation/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(HiveCampAdapter());
  Hive.registerAdapter(HiveBandAdapter());
  await Hive.openBox<HiveCamp>('HiveCampBox');
  await Hive.openBox<HiveCamp>('HiveGarbageBox');
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const GarbagePage(),
        '/second': (context) => const MyHomePage(),
      },
      onGenerateInitialRoutes: (initialRoute) {
        return [
          MaterialPageRoute(builder: (_) => const GarbagePage()),
          MaterialPageRoute(builder: (_) => const MyHomePage()),
        ];
      },
    );
  }
}