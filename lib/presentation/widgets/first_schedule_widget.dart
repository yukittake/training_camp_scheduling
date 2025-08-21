import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/widgets/scheduling_button.dart';
import 'package:training_camp_scheduling/presentation/widgets/select_rooms_widget.dart';
import 'package:flutter/material.dart';

class FirstScheduleWidget extends StatelessWidget {
  final int _rooms;
  final int _campIndex;
  final List<List<TextEditingController>> _bandControllerList;
  const FirstScheduleWidget({super.key,required rooms,required campIndex,required bandControllerList}):
          _rooms=rooms,
          _campIndex=campIndex,
          _bandControllerList=bandControllerList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectRoomsWidget(index: _campIndex,rooms: _rooms,width: MediaQuery.of(context).size.width*0.94,),
          SizedBox(height: 30,)
          ,
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: AppColor.shadowBlue,blurRadius: 20,offset: Offset(0, 0))
              ],
            ),
            child: SchedulingButton(campIndex: _campIndex, bandControllerList: _bandControllerList),
          ),
        ],
      ),
    );
  }
}