import 'package:flutter/material.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/widgets/scheduling_button.dart';
import 'package:training_camp_scheduling/presentation/widgets/select_rooms_widget.dart';

class FirstScheduleWidget extends StatelessWidget {
  final int _index;
  final int _rooms;
  const FirstScheduleWidget({super.key,required rooms,required index}):
    _rooms=rooms,
    _index=index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectRoomsWidget(index: _index,rooms: _rooms,width: MediaQuery.of(context).size.width*0.94,),
          SizedBox(height: 30,)
          ,
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: AppColor.shadowBlue,blurRadius: 20,offset: Offset(0, 0))
              ],
            ),
            child: SchedulingButton(),
          ),
        ],
      ),
    );
  }
}