import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(primary:const Color.fromARGB(255, 148, 212, 187),seedColor: const Color.fromARGB(255, 148, 212, 187)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<String> entries = <String>['A', 'B', 'C',];
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.add,size: 50,color: theme.colorScheme.primary,)
        ],
      ),
      body: SizedBox(
        width:double.infinity,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text(
              "全てのプロジェクト",
              style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: theme.colorScheme.primary,
                    child: Center(child: Text(entries[index])),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              )
              // ListView(
              //   padding: const EdgeInsets.all(8),
              //   children:[
              //     Container(
              //       height: 50,
              //       color: theme.colorScheme.primary,
              //       child: const Center(child: Text('Entry C')),
              //     ),
                  

              //   ],
              // ),
            )
          ],
        ),
      )
    );
  }
}
