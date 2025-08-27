import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/presentation/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/widgets/download_csv_button.dart';
import 'package:training_camp_scheduling/presentation/widgets/room_button.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectRoomsWidget(campIndex: widget._campIndex, rooms: widget._rooms, width: MediaQuery.of(context).size.width-175.0),
                ),
                SchedulingButton(campIndex: widget._campIndex, bandControllerList: widget._bandControllerList)
              ],
            ),
          ),
          Align(alignment: Alignment.centerRight,child: DownloadCsvButton(campIndex: widget._campIndex,)),
          Padding(
            padding: const EdgeInsets.only(right: 10.0,left: 10.0),
            child: SizedBox(
              height: 70,
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
          )
        ],
      ),
    );
  }
}