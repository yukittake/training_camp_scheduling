import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/application/state/camp_state.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';


class ManageBandWidget extends ConsumerWidget {
  final void Function(int,int) _createDeleteOverlay;
  final void Function() _removeDeleteOverlay;
  final List<LayerLink> _links;
  final List<List<TextEditingController>> _bandControllerList;
  final List<FocusNode> _focusNodeList;
  final ScrollController _scrollController;
  final Band _aBand;
  final int _bandIndex;
  final int _campIndex;
  final OverlayEntry? _overlayEntry;
  const ManageBandWidget({super.key,required aBand,required bandIndex,required campIndex,required links,required bandControllerList,required overlayEntry,required createDeleteOverlay,required removeDeleteOverlay,required focusNodeList,required scrollController}):
    _aBand=aBand,
    _bandIndex=bandIndex,
    _campIndex=campIndex,
    _links=links,
    _bandControllerList=bandControllerList,
    _overlayEntry=overlayEntry,
    _createDeleteOverlay=createDeleteOverlay,
    _removeDeleteOverlay=removeDeleteOverlay,
    _focusNodeList=focusNodeList,
    _scrollController=scrollController;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<Widget> children=[];
    for(int i=0;i<_aBand.members.length;i++){
      if(i==0){
        children.add(Padding(padding: EdgeInsetsGeometry.only(top:15)),);
        children.add(Padding(
          padding: const EdgeInsets.only(left: 40),
          child: TextField(
                controller: _bandControllerList[_bandIndex][i+1],
                onChanged: (newMemberName) {
                  final notifier=ref.read(campStateNotifierProvider.notifier);
                  notifier.updateMember(_campIndex, _bandIndex, i, newMemberName);
                },
                focusNode: (i==_aBand.members.length-1) ? _focusNodeList[_bandIndex] : null,
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
                controller: _bandControllerList[_bandIndex][i+1],
                focusNode: (i==_aBand.members.length-1) ? _focusNodeList[_bandIndex] : null,
                onChanged: (newMemberName) {
                  final notifier=ref.read(campStateNotifierProvider.notifier);
                  notifier.updateMember(_campIndex, _bandIndex, i, newMemberName);
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
        notifier.addMember(_campIndex, _bandIndex);
        _bandControllerList[_bandIndex].add(TextEditingController(text:""));
        _focusNodeList[_bandIndex].unfocus();
        WidgetsBinding.instance.addPostFrameCallback((_) async{
          _focusNodeList[_bandIndex].requestFocus();
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
              BoxShadow(color: AppColor.shadowDeep,blurRadius: 4,offset: _aBand.open ? Offset(-4,4) : Offset(-8,8))
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
                            turns: _aBand.open ? 0 : -0.25,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(Icons.expand_more,size: 40,color: AppColor.greySubString,)
                          ),
                          onTap: (){
                            final notifier=ref.read(campStateNotifierProvider.notifier);
                            notifier.turnOpen(_campIndex, _bandIndex);
                          },
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _bandControllerList[_bandIndex][0],
                          onChanged: (title){
                            final notifier=ref.read(campStateNotifierProvider.notifier);
                            notifier.updateBand(_campIndex, _bandIndex, title);
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
                      link: _links[_bandIndex],
                      child: GestureDetector(
                        onTap: () {
                          if(_overlayEntry == null){
                            _createDeleteOverlay(_bandIndex,_aBand.members.length);
                          }else{
                            _removeDeleteOverlay();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: BoxBorder.all(color: AppColor.greyWidgetLine,width: 2),
                            shape: BoxShape.circle, 
                          ),
                          child: Icon(
                            Icons.more_horiz,
                            color: AppColor.greyWidgetLine,    
                            size: 20,            
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
                    heightFactor: _aBand.open ? 1 : 0,
                    child: Column(mainAxisSize: MainAxisSize.min,children: children,),
                  )
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}