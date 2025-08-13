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
  final List<LayerLink> _links=[];
  late final ScrollController _scrollController;
  OverlayEntry? _overlayEntry;

  int currentPageIndex=0;
  void _removeDeleteOverlay(){
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }
  void _createDeleteOverlay(int bandIndex,int members){
    const padding=8.0;
    const margin=5.0;
    _removeDeleteOverlay();
    _overlayEntry = OverlayEntry(builder: (context) {

      return Stack(
        children: [
          GestureDetector(onTap: ()=>_removeDeleteOverlay(),child: Container(color:AppColor.transparent)),
          CompositedTransformFollower(
            link: _links[bandIndex],
            offset: Offset(-120,-30),
            child: SafeArea(
              child:  Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(color: AppColor.shadowDeep,blurRadius: 4,offset: Offset(-4,4))
                  ],
                  border: Border.all(
                    color:AppColor.greyWidgetLine,
                    width:1
                  ),
                  borderRadius: BorderRadius.circular(30)
                ),
                height: 40*(members+1)+padding*2+margin, //text:39pixel + divider(container) 1pixel
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(padding),
                  child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(), 
                        itemCount: members+1,
                        itemBuilder: (BuildContext context,int index){
                          return GestureDetector(
                            onTap: (){
                              final notifier=ref.read(campStateNotifierProvider.notifier);
                              if(index==members){
                                notifier.deleteBand(widget.index, bandIndex);
                                for(TextEditingController temp in _bandControllerList[bandIndex]){
                                  temp.dispose();
                                }
                                _bandControllerList.removeAt(bandIndex);
                                _links.removeAt(bandIndex);
                                _focusNodeList[bandIndex].dispose();
                                _focusNodeList.removeAt(bandIndex);
                              }else{
                                notifier.deleteMember(widget.index, bandIndex, index);
                                _bandControllerList[bandIndex][index+1].dispose();
                                _bandControllerList[bandIndex].removeAt(index+1);
                              }
                              _removeDeleteOverlay();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(index==members ? "バンドを削除" : "メンバー${index+1}を削除",style:AppText.delete),
                                  Icon(index==members ? Icons.delete : Icons.person,size: 19,color: AppColor.red,)
                                ],
                              ),
                            ),
                          );
                        }, 
                        separatorBuilder: (BuildContext context,int index)=>Container(height: 1,color: AppColor.greyWidgetLine,)
                  ),
                ),
              )
            )
          )
        ],
      );
    },);
    Overlay.of(context,debugRequiredFor: widget).insert(_overlayEntry!);
  }

  @override
  void initState(){
    super.initState();
    final campState=ref.read(campStateNotifierProvider);
    _scrollController=ScrollController();
    _titleController=TextEditingController(text:campState[widget.index].campTitle);
    for(Band temp in campState[widget.index].bands){
      List<TextEditingController> templ=[TextEditingController(text:temp.bandTitle)];
      _focusNodeList.add(FocusNode());
      _links.add(LayerLink());
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
    _removeDeleteOverlay();
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
            _links.add(LayerLink());

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
              List<Widget> children=[];
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve:Curves.easeInOut,
                    padding: EdgeInsetsGeometry.only(top: 30,bottom: 30,right: 30),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(color: AppColor.shadowDeep,blurRadius: 4,offset: aBand.open ? Offset(-4,4) : Offset(-8,8))
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
                              child:CompositedTransformTarget(
                                link: _links[index],
                                child: GestureDetector(
                                  onTap: () {
                                    if(_overlayEntry == null){
                                      _createDeleteOverlay(index,campState[widget.index].bands[index].members.length);
                                    }else{
                                      _removeDeleteOverlay();
                                    }
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