import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/application/state/camp_state.dart';
import 'package:training_camp_scheduling/domain/features/greedy_scheduling.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';


class SecondPage extends ConsumerStatefulWidget {
  final int index;
  const SecondPage({super.key,required this.index});

  @override
  ConsumerState<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<SecondPage> {
  late final TextEditingController titleController;
  List<List<TextEditingController>> bandControllerList=[]; //listの先頭がバンド名、それ以降がメンバー
  @override
  void initState(){
    super.initState();
    final campState=ref.read(campStateNotifierProvider);
    titleController=TextEditingController(text:campState[widget.index].campTitle);
    for(Band temp in campState[widget.index].bands){
      List<TextEditingController> templ=[TextEditingController(text:temp.bandTitle)];
      for(String str in temp.members){
        templ.add(TextEditingController(text:str));
      }
      bandControllerList.add(templ);
    }
  }
  @override
  void dispose(){
    titleController.dispose();
    for(List<TextEditingController> tempList in bandControllerList){
      for(TextEditingController temp in tempList){
        temp.dispose();
      }
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final campState=ref.watch(campStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title:TextField(
          controller: titleController,
          onChanged: (text){
            final notifier=ref.read(campStateNotifierProvider.notifier);
            notifier.updateTitle(widget.index,text);
          },
        )
      ),
      floatingActionButton:  FloatingActionButton(onPressed:(){
          final notifier=ref.read(campStateNotifierProvider.notifier);
          notifier.addBand(widget.index);
          bandControllerList.add([TextEditingController(text:"")]);
        },
        shape: CircleBorder(),
        child: Icon(Icons.add,),
      ),
      body:ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: campState[widget.index].bands.length+1,//初めのウィジェット分プラス１
        itemBuilder: (BuildContext context, int index) {
          if(index==0){
            return Column(children: [
              ElevatedButton(onPressed: (){
                final campList=ref.read(campStateNotifierProvider);
                List<List<Band>> result =greedyScheduling(campList[widget.index].bands, 5);
                for(List<Band> bandList in result){
                  print("--------------");
                  for(Band tempBand in bandList){
                    print("${tempBand.bandTitle}");
                  }
                }
              }, child: Text("作成開始/空白、未入力未対応")),
              SizedBox(width: double.infinity,height:300,child: Placeholder(),),
            ],);
          }else{
            final aBand=campState[widget.index].bands[index-1];
            List <Widget>children=[
              Row(
                  children: [
                    Text("バンド名:"),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: bandControllerList[index-1][0],
                          onChanged: (title){
                            final notifier=ref.read(campStateNotifierProvider.notifier);
                            notifier.updateBand(widget.index, index-1, title);
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: (){
                      for(TextEditingController listCon in bandControllerList[index-1]){
                        listCon.dispose();
                      }
                      bandControllerList.removeAt(index-1);
                      final notifier=ref.read(campStateNotifierProvider.notifier);
                      notifier.deleteBand(widget.index,index-1);
                    }, child: Icon(Icons.delete))
                  ],
              ),
            ];
            for(int i=0;i<aBand.members.length;i++){
              children.add(
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left:50),
                    child: Text("メンバー${i+1}:"),
                  ),
                  Expanded(child:TextField(
                    controller: bandControllerList[index-1][i+1],
                    onChanged: (newMemberName) {
                      final notifier=ref.read(campStateNotifierProvider.notifier);
                      notifier.updateMember(widget.index, index-1, i, newMemberName);
                    },
                  )),
                  ElevatedButton(onPressed: (){
                      bandControllerList[index-1][i+1].dispose();
                      bandControllerList[index-1].removeAt(i+1);
                      final notifier=ref.read(campStateNotifierProvider.notifier);
                      notifier.deleteMember(widget.index, index-1, i);
                    }, child: Icon(Icons.delete))
                ],)
              );
            }
            children.add(IconButton(onPressed: (){
              final notifier=ref.read(campStateNotifierProvider.notifier);
              notifier.addMember(widget.index, index-1);
              bandControllerList[index-1].add(TextEditingController(text:""));
            }, icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text("メンバーを追加")
              ],
            )));
            return Column(children: children);
          }
          

        },  
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
    );
  }
}