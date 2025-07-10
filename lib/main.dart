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
        colorScheme: ColorScheme.fromSeed(
          primary: const Color.fromARGB(255, 68, 210, 155),
          seedColor: const Color.fromARGB(255, 148, 212, 187),
        ),
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
  List<String> entries = <String>['無題'];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
                "all",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                entries.add('無題');
              });
            },
            icon: Icon(Icons.add, size: 50, color: theme.colorScheme.primary),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(13)
                  ),
                  child: ListView.separated(
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Widget> children = [];
                      if (index == 0) {
                        children.add(Divider());
                      }
                      children.add(Choices(entries: entries, index: index));
                      if (index == entries.length - 1) {
                        children.add(Divider());
                      }
                      return Column(children: children);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Choices extends StatelessWidget {
  const Choices({
    super.key,
    required this.index,
    required this.entries,
  });

  final int index;
  final List<String> entries;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
      },
      child: SizedBox(
        height: 70,
        child: Center(
          child: Text(
            entries[index],
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
