import 'package:flutter/material.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/widgets/scheduling_button.dart';
import 'package:training_camp_scheduling/presentation/widgets/select_rooms_widget.dart';

class FirstScheduleWidget extends StatelessWidget {
  final int _rooms;
  final List<Band> _bands;
  final int _index;
  final List<List<TextEditingController>> _bandControllerList;
  const FirstScheduleWidget({super.key,required rooms,required bands,required index,required bandControllerList}):
          _rooms=rooms,
          _bands=bands,
          _index=index,
          _bandControllerList=bandControllerList;

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
            child: SchedulingButton(rooms: _rooms, bands: _bands, index: _index, bandControllerList: _bandControllerList),
          ),
        ],
      ),
    );
  }
}