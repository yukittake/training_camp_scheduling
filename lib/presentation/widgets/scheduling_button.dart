import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/application/usecases/make_schedule.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';

class SchedulingButton extends ConsumerWidget {
  final int _rooms;
  final List<Band> _bands;
  final int _index;
  final List<List<TextEditingController>> _bandControllerList;
  const SchedulingButton({super.key,required rooms,required bands,required index,required bandControllerList}):
          _rooms=rooms,
          _bands=bands,
          _index=index,
          _bandControllerList=bandControllerList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(onPressed: (){
      try{
        final tempBool=makeSchedule(_rooms, _bands, ref, _index, _bandControllerList);
        if(tempBool){
          print("空白のメンバーを削除しました");
          //dialogs
        }
      }catch(e){
        print("$e"); //dialogs
      }
    },style:FilledButton.styleFrom(backgroundColor: AppColor.lightBlue,textStyle: AppText.smallWhite,),
      child: SizedBox(
        width: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit,size: 17,),
            SizedBox(width: 10,),
            const Text('スケジュール作成'),
          ],
        ),
      ),
    );
  }
}