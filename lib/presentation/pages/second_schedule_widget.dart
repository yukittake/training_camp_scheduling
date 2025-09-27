import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/presentation/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';
import 'package:training_camp_scheduling/presentation/widgets/download_csv_button.dart';
import 'package:training_camp_scheduling/presentation/widgets/room_button.dart';
import 'package:training_camp_scheduling/presentation/widgets/room_schedule_widget.dart';
import 'package:training_camp_scheduling/presentation/widgets/scheduling_button.dart';
import 'package:training_camp_scheduling/presentation/widgets/select_rooms_widget.dart';

class SecondScheduleWidget extends ConsumerStatefulWidget {
  final int _campIndex;
  final int _rooms;
  final List<List<TextEditingController>> _bandControllerList;
  const SecondScheduleWidget({super.key,required campIndex, required rooms,required bandControllerList}):
    _campIndex = campIndex,
    _rooms = rooms,
    _bandControllerList = bandControllerList;

  @override
  ConsumerState<SecondScheduleWidget> createState() => _SecondScheduleWidgetState();
}

class _SecondScheduleWidgetState extends ConsumerState<SecondScheduleWidget> {
  late final ScrollController _scrollController;
  int _currentRoom=0;
  void _onPressed(int value){
    setState(() {
      _currentRoom=value;
    });
  }

  @override
  void initState(){
    super.initState();
    _scrollController=ScrollController();
  }
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final campState=ref.watch(campStateNotifierProvider);
    final List<List<Band>> fixed = campState[widget._campIndex].fillNullInSchedule();
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,right: 8.0),
                  child: SelectRoomsWidget(campIndex: widget._campIndex, rooms: widget._rooms, width: MediaQuery.of(context).size.width*0.96-158.0),
                ),
                SchedulingButton(campIndex: widget._campIndex, bandControllerList: widget._bandControllerList)
              ],
            ),
          ),
          Align(alignment: Alignment.centerRight,child: DownloadCsvButton(campIndex: widget._campIndex,)),
          SizedBox(
            height: 70,
            width: MediaQuery.of(context).size.width*0.96,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,itemCount: campState[widget._campIndex].maxRooms(),
                itemBuilder: (context, index){
                  return RoomButton(currentRoom: _currentRoom,onPressed: _onPressed,roomNumber: index,);
                },
                separatorBuilder: (BuildContext context, int index) => const Padding(padding: EdgeInsets.only(left: 20,right: 20),),
              ),
            ),
          ),
          Column(
            children: List.generate(
              fixed.length, (index) => IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text("${index+1}時間目",style: AppText.greyMainString,),
                    ),
                    VerticalDivider(width: 24,thickness:1.0,color: AppColor.black,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: RoomScheduleWidget(currentRoom: _currentRoom,timeIndex: index,filledSchedule: fixed,),
                    ),
                  ],
                ),
              )
            ).toList(),
          )
        ],
      ),
    );
  }
}