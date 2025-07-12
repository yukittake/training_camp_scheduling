import 'second_page.dart';
import 'package:flutter/cupertino.dart';
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
  List<String> entries = <String>["A","B","C"];
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
                child: ListView.separated(
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Widget> children = [];
                    if (index == 0) {
                      children.add(
                        Column(
                          children: [
                            Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ),
                            Container(height: 1, color: Colors.grey),
                          ],
                        ),
                      );
                    }
                    children.add(
                      GestureDetector(
                        onHorizontalDragEnd: (details){
                          if (details.velocity.pixelsPerSecond.dx < 0){
                            setState((){
                              entries.removeAt(index);
                            });
                            print("swipe");
                          }
                        },
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondPage()),
                        );
                        },
                        child: Container(
                          color: Colors.white,
                          height: 70,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15),
                            child: Text(
                              entries[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                    if (index == entries.length - 1) {
                      children.add(
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                          children: [
                            Container(height: 1, color: Colors.grey),
                            Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ),
                      );
                    }
                    return Column(children: children);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(height: 1, color: Colors.grey) 
                      ,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
