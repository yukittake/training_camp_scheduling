import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/application/state/camp_box_provider.dart';
import 'package:training_camp_scheduling/application/state/camp_state.dart';
import 'package:training_camp_scheduling/application/types/camp.dart';
import 'package:training_camp_scheduling/presentation/pages/second_page.dart';

class MyHomePage extends ConsumerWidget{
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final campBox=ref.watch(campBoxProvider);
    final campState=ref.watch(campStateNotifierProvider);
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
              final notifier=ref.read(campStateNotifierProvider.notifier);
              notifier.add();
              campBox.put('1',Camp());
              print(campBox.keys);
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
                  itemCount: campState.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Widget> children = [];
                    final reversedIndex = campState.length - 1 - index;
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
                          final notifier=ref.read(campStateNotifierProvider.notifier);
                          if (details.velocity.pixelsPerSecond.dx < 0){
                            notifier.delete(reversedIndex);
                            campBox.delete('1');
                            print(campBox.keys);
                          }
                        },
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondPage(index:reversedIndex)),
                        );
                        },
                        child: Container(
                          color: Colors.white,
                          height: 70,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left:15),
                            child: Text(
                              campState[reversedIndex].campTitle,
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
                    if (index == campState.length - 1) {
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
                  separatorBuilder: (BuildContext context, int reversedIndex) =>
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
