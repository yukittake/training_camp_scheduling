import 'package:training_camp_scheduling/domain/types/training_camp_class.dart';
import 'package:training_camp_scheduling/application/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/pages/home_page.dart';

import 'presentation/pages/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
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
