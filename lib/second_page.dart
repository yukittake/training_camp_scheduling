import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/camp_state.dart';


class SecondPage extends ConsumerStatefulWidget {
  final int index;
  const SecondPage({super.key,required this.index});

  @override
  ConsumerState<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<SecondPage> {
  late final TextEditingController myController;
  @override
  void initState(){
    super.initState();
    final campState=ref.read(campStateNotifierProvider);
    myController=TextEditingController(text:campState[widget.index].campTitle);
  }
  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final campState=ref.watch(campStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        
      ),
      floatingActionButton:  FloatingActionButton(onPressed:(){
          final notifier=ref.read(campStateNotifierProvider.notifier);
          notifier.addBand(widget.index);
        },
        shape: CircleBorder(),
        child: Icon(Icons.add,),
      ),
      // body: ListView(children: [
      //     SizedBox(width: double.infinity,height:300,child: Placeholder(),),
      //     Row(
      //       children: [
      //         Text("タイトル:"),
      //         Expanded(
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: TextField(
      //               controller: myController,
      //               onChanged: (text){
      //                 final notifier=ref.read(campStateNotifierProvider.notifier);
      //                 notifier.updateTitle(widget.index,text);
      //               },
      //             ),
      //           ),
      //         ),
      //       ],
      //     )
      //   ]
      // ),
      body:ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: campState[widget.index].bands.length+1,//初めのウィジェット分プラス１
        itemBuilder: (BuildContext context, int index) {
          if(index==0){
            return Column(children: [
              SizedBox(width: double.infinity,height:300,child: Placeholder(),),
              Row(
                children: [
                  Text("タイトル:"),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: myController,
                        onChanged: (text){
                          final notifier=ref.read(campStateNotifierProvider.notifier);
                          notifier.updateTitle(widget.index,text);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],);
          }else{
            return Row(
                children: [
                  Text("バンド$index:"),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(),
                    ),
                  ),
                ],
              );
          }
          

        },  
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
    );
  }
}