import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/presentation/widgets/download_csv_button.dart';
import 'package:training_camp_scheduling/presentation/widgets/scheduling_button.dart';
import 'package:training_camp_scheduling/presentation/widgets/select_rooms_widget.dart';

class SecondScheduleWidget extends ConsumerWidget {
  final int _campIndex;
  final int _rooms;
  final List<List<TextEditingController>> _bandControllerList;
  const SecondScheduleWidget({super.key,required campIndex, required rooms,required bandControllerList}):
    _campIndex = campIndex,
    _rooms = rooms,
    _bandControllerList = bandControllerList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectRoomsWidget(campIndex: _campIndex, rooms: _rooms, width: MediaQuery.of(context).size.width-175.0),
              ),
              SchedulingButton(campIndex: _campIndex, bandControllerList: _bandControllerList)
            ],
          ),
        ),
        Align(alignment: Alignment.centerRight,child: DownloadCsvButton(campIndex: _campIndex,))
      ],
    );
  }
}