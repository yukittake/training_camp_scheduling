import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/application/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';

class DeleteOverlayWidget extends ConsumerWidget {
  final void Function() _removeDeleteOverlay;
  final List<LayerLink> _links;
  final List<List<TextEditingController>> _bandControllerList;
  final int _bandIndex;
  final int _members;
  final int _campIndex;
  final List<FocusNode> _focusNodeList;
  const DeleteOverlayWidget({super.key,required removeDeleteOverlay,required links,required bandIndex,required members,required campIndex,required bandControllerList,required focusNodeList})
  : _removeDeleteOverlay=removeDeleteOverlay, 
    _links=links,
    _bandIndex=bandIndex,
    _members=members,
    _campIndex=campIndex,
    _bandControllerList=bandControllerList,
    _focusNodeList=focusNodeList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const padding=8.0;
    const margin=5.0;
    return Stack(
        children: [
          GestureDetector(onTap: ()=>_removeDeleteOverlay(),child: Container(color:AppColor.transparent)),
          CompositedTransformFollower(
            link: _links[_bandIndex],
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
                height: 40*(_members+1)+padding*2+margin, //text:39pixel + divider(container) 1pixel
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(padding),
                  child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(), 
                        itemCount: _members+1,
                        itemBuilder: (BuildContext context,int index){
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              final notifier=ref.read(campStateNotifierProvider.notifier);
                              if(index==_members){
                                notifier.deleteBand(_campIndex, _bandIndex);
                                for(TextEditingController temp in _bandControllerList[_bandIndex]){
                                  temp.dispose();
                                }
                                _bandControllerList.removeAt(_bandIndex);
                                _links.removeAt(_bandIndex);
                                _focusNodeList[_bandIndex].dispose();
                                _focusNodeList.removeAt(_bandIndex);
                              }else{
                                notifier.deleteMember(_campIndex, _bandIndex, index);
                                _bandControllerList[_bandIndex][index+1].dispose();
                                _bandControllerList[_bandIndex].removeAt(index+1);
                              }
                              _removeDeleteOverlay();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(index==_members ? "バンドを削除" : "メンバー${index+1}を削除",style:AppText.delete),
                                  Icon(index==_members ? Icons.delete : Icons.person,size: 19,color: AppColor.red,)
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
  }
}