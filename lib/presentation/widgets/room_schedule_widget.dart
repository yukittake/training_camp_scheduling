import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';

class RoomScheduleWidget extends ConsumerWidget {
  final int _campIndex;
  final int _currentRoom;
  final List<List<Band>> _filledSchedule;
  final int _timeIndex;
  const RoomScheduleWidget({super.key,required campIndex, required currentRoom, required filledSchedule, required timeIndex}):
    _campIndex=campIndex,
    _currentRoom=currentRoom,
    _filledSchedule=filledSchedule,
    _timeIndex=timeIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children=<Widget>[Text(_filledSchedule[_timeIndex][_currentRoom].bandTitle,style: AppText.subTitle,)];
    for(String member in _filledSchedule[_timeIndex][_currentRoom].members){
      children.add(Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: Row(
          children: [
            Icon(Icons.person,size: 15,color: AppColor.greyMainString,),
            Text(member,style: AppText.greyMainString,),
          ],
        ),
      ));
    }
    return Container(
      width: MediaQuery.of(context).size.width*0.90-79.0, //Text55+縦棒24
      decoration: BoxDecoration(
        color: AppColor.greyBack,
        border: Border.all(color: AppColor.greyWidgetLine,width: 3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 35,top:5,bottom:5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
        ),
      ),
    );
  }
}