import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/application/state/camp_state.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';


class SecondPage extends ConsumerStatefulWidget {
  final int index;
  const SecondPage({super.key,required this.index});

  @override
  ConsumerState<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends ConsumerState<SecondPage> {
  late final TextEditingController _titleController;
  final List<List<TextEditingController>> _bandControllerList=[]; //listの先頭がバンド名、それ以降がメンバー
  final List<FocusNode> _focusNodeList=[];
  late final ScrollController _scrollController;

  int currentPageIndex=0;

  @override
  void initState(){
    super.initState();
    final campState=ref.read(campStateNotifierProvider);
    _scrollController=ScrollController();
    _titleController=TextEditingController(text:campState[widget.index].campTitle);
    for(Band temp in campState[widget.index].bands){
      List<TextEditingController> templ=[TextEditingController(text:temp.bandTitle)];
      _focusNodeList.add(FocusNode());
      for(String str in temp.members){
        templ.add(TextEditingController(text:str));
      }
      _bandControllerList.add(templ);
    }
  }
  @override
  void dispose(){
    _scrollController.dispose();
    _titleController.dispose();
    for(FocusNode temp in _focusNodeList){
      temp.dispose();
    }
    for(List<TextEditingController> tempList in _bandControllerList){
      for(TextEditingController temp in tempList){
        temp.dispose();
      }
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final campState=ref.watch(campStateNotifierProvider);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColor.white,
          surfaceTintColor: Colors.transparent,
          title:TextField(
            decoration: const InputDecoration(
              border: InputBorder.none
            ),
            controller: _titleController,
            style:AppText.title,
            onChanged: (text){
              final notifier=ref.read(campStateNotifierProvider.notifier);
              notifier.updateTitle(widget.index,text);
            },
          ),
          actions: [IconButton(onPressed: (){
            final notifier=ref.read(campStateNotifierProvider.notifier);
            notifier.addBand(widget.index);
            _bandControllerList.add([TextEditingController(text:"")]);
            _focusNodeList.add(FocusNode());
            WidgetsBinding.instance.addPostFrameCallback((_){
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutCubic
              );
            });
          }, icon: Icon(Icons.add_circle,size: 45,color: AppColor.black,))], 
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (value) {
            setState(() {
              currentPageIndex = value;
            });
          },
          backgroundColor: AppColor.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: AppColor.white,
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.diversity_3),
              icon: Icon(Icons.diversity_3,color: AppColor.greyWidgetLine,),
              label: 'バンド管理',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.calendar_today),
              icon: Icon(Icons.calendar_today,color: AppColor.greyWidgetLine,),
              label: 'スケジューリング',
            ),
          ],
        ),
        body:[
          if(campState[widget.index].bands.isEmpty) Center(child: Text("＋でバンドを追加",style:AppText.annotation,))
          else ListView.separated(
            controller: _scrollController,
            itemCount: campState[widget.index].bands.length,
            itemBuilder: (BuildContext context, int index){
              final aBand=campState[widget.index].bands[index];
              List<Widget> children=[
                Stack(
                  children: []
                ),
              ];
              for(int i=0;i<aBand.members.length;i++){
                if(i==0){
                  children.add(Padding(padding: EdgeInsetsGeometry.only(top:15)),);
                  children.add(Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: TextField(
                          controller: _bandControllerList[index][i+1],
                          onChanged: (newMemberName) {
                            final notifier=ref.read(campStateNotifierProvider.notifier);
                            notifier.updateMember(widget.index, index, i, newMemberName);
                          },
                          focusNode: (i==aBand.members.length-1) ? _focusNodeList[index] : null,
                          style: AppText.normal,
                          decoration: InputDecoration(
                            hintStyle: AppText.formAnnotation,
                            labelText: "メンバー",
                            hintText: "メンバー１",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:AppColor.greyWidgetLine
                              )
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:AppColor.black)
                            )
                          ),
                        ),
                  )
                  );
                }else{
                  children.add(Padding(padding: EdgeInsetsGeometry.only(top:3)));
                  children.add(
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: TextField(
                          controller: _bandControllerList[index][i+1],
                          focusNode: (i==aBand.members.length-1) ? _focusNodeList[index] : null,
                          onChanged: (newMemberName) {
                            final notifier=ref.read(campStateNotifierProvider.notifier);
                            notifier.updateMember(widget.index, index, i, newMemberName);
                          },
                          style: AppText.normal,
                          decoration: InputDecoration(
                            hintStyle: AppText.formAnnotation,
                            hintText: "メンバー${i+1}",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:AppColor.greyWidgetLine
                              )
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:AppColor.black)
                            )
                          ),
                      ),
                    )
                  );
                }
              }
              children.add(
                IconButton(onPressed: (){
                  final notifier=ref.read(campStateNotifierProvider.notifier);
                  notifier.addMember(widget.index, index);
                  _bandControllerList[index].add(TextEditingController(text:""));
                  _focusNodeList[index].unfocus();
                  WidgetsBinding.instance.addPostFrameCallback((_) async{
                    _focusNodeList[index].requestFocus();
                    final delta=50;
                    Future.delayed(Duration(milliseconds: 1000),(){
                      _scrollController.animateTo(
                      (_scrollController.offset+delta).clamp(0,_scrollController.position.maxScrollExtent),
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOutCubic
                      );
                    });
                  });
                }, icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("＋メンバーを追加",style: AppText.formAnnotation,)
                  ],
                ))
              );
              return Align(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: EdgeInsetsGeometry.only(top: 30,bottom: 30,right: 30),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(color: AppColor.shadowDeep,blurRadius: 4,offset: Offset(-4,4))
                      ],
                      border: Border.all(
                        color:AppColor.greyWidgetLine,
                        width:3
                      ),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    width: MediaQuery.of(context).size.width*0.94,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children:[
                        Stack(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: GestureDetector(
                                    child:AnimatedRotation(
                                      turns: aBand.open ? 0 : -0.25,
                                      duration: const Duration(milliseconds: 200),
                                      child: Icon(Icons.expand_more,size: 40,color: AppColor.greySubString,)
                                    ),
                                    onTap: (){
                                      final notifier=ref.read(campStateNotifierProvider.notifier);
                                      notifier.turnOpen(widget.index, index);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _bandControllerList[index][0],
                                    onChanged: (title){
                                      final notifier=ref.read(campStateNotifierProvider.notifier);
                                      notifier.updateBand(widget.index, index, title);
                                    },
                                    style: AppText.normal,
                                    decoration: InputDecoration(
                                      labelText: "バンド名",
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color:AppColor.greyWidgetLine
                                        )
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color:AppColor.black)
                                      )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right:0,top: 0,
                              child:GestureDetector(
                                onTap: () {
                                  
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: BoxBorder.all(color: AppColor.greyWidgetLine,width: 2),
                                    shape: BoxShape.circle,  // 丸背景
                                  ),
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: AppColor.greyWidgetLine,     // アイコン色
                                    size: 20,                // アイコンサイズ
                                  ),
                                ),
                              )
                            )
                          ]
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          child:ClipRect(
                            child: Align(
                              heightFactor: aBand.open ? 1 : 0,
                              child: Column(mainAxisSize: MainAxisSize.min,children: children,),
                            )
                          )
                        )
                      ]
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Padding(padding: EdgeInsets.only(top: 30),),
          )









        //   ListView.separated(
        //   padding: const EdgeInsets.all(8),
        //   itemCount: campState[widget.index].bands.length+1,//初めのウィジェット分プラス１
        //   itemBuilder: (BuildContext context, int index) {
        //     if(index==0){
        //       return Column(children: [
        //         ElevatedButton(onPressed: (){
        //           final campList=ref.read(campStateNotifierProvider);
        //           List<List<Band>> result =greedyScheduling(campList[widget.index].bands, 5);
        //           for(List<Band> bandList in result){
        //             print("--------------");
        //             for(Band tempBand in bandList){
        //               print("${tempBand.bandTitle}");
        //             }
        //           }
        //         }, child: Text("作成開始/空白、未入力未対応")),
        //         SizedBox(width: double.infinity,height:300,child: Placeholder(),),
        //       ],);
        //     }else{
        //       final aBand=campState[widget.index].bands[index-1];
        //       List <Widget>children=[
        //         Row(
        //             children: [
        //               Text("バンド名:"),
        //               Expanded(
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: TextField(
        //                     controller: bandControllerList[index-1][0],
        //                     onChanged: (title){
        //                       final notifier=ref.read(campStateNotifierProvider.notifier);
        //                       notifier.updateBand(widget.index, index-1, title);
        //                     },
        //                   ),
        //                 ),
        //               ),
        //               ElevatedButton(onPressed: (){
        //                 for(TextEditingController listCon in bandControllerList[index-1]){
        //                   listCon.dispose();
        //                 }
        //                 bandControllerList.removeAt(index-1);
        //                 final notifier=ref.read(campStateNotifierProvider.notifier);
        //                 notifier.deleteBand(widget.index,index-1);
        //               }, child: Icon(Icons.delete))
        //             ],
        //         ),
        //       ];
        //       for(int i=0;i<aBand.members.length;i++){
        //         children.add(
        //           Row(children: [
        //             Padding(
        //               padding: const EdgeInsets.only(left:50),
        //               child: Text("メンバー${i+1}:"),
        //             ),
        //             Expanded(child:TextField(
        //               controller: bandControllerList[index-1][i+1],
        //               onChanged: (newMemberName) {
        //                 final notifier=ref.read(campStateNotifierProvider.notifier);
        //                 notifier.updateMember(widget.index, index-1, i, newMemberName);
        //               },
        //             )),
        //             ElevatedButton(onPressed: (){
        //                 bandControllerList[index-1][i+1].dispose();
        //                 bandControllerList[index-1].removeAt(i+1);
        //                 final notifier=ref.read(campStateNotifierProvider.notifier);
        //                 notifier.deleteMember(widget.index, index-1, i);
        //               }, child: Icon(Icons.delete))
        //           ],)
        //         );
        //       }
        //       children.add(IconButton(onPressed: (){
        //         final notifier=ref.read(campStateNotifierProvider.notifier);
        //         notifier.addMember(widget.index, index-1);
        //         bandControllerList[index-1].add(TextEditingController(text:""));
        //       }, icon: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(Icons.add),
        //           Text("メンバーを追加")
        //         ],
        //       )));
        //       return Column(children: children);
        //     }
            
              
        //   },  
        //   separatorBuilder: (BuildContext context, int index) => const Divider(),
        // )
        ,
        Column(
          children: [
            Text("hi",),
            Text("hi")
          ],
        )
        ][currentPageIndex]
      ),
    );
  }
}