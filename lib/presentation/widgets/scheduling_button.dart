import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/domain/entities/exception_bandtitle.dart';
import 'package:training_camp_scheduling/presentation/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulingButton extends ConsumerWidget {
  final int _campIndex;
  final List<List<TextEditingController>> _bandControllerList;
  const SchedulingButton({super.key,required campIndex,required bandControllerList}):
          _campIndex=campIndex,
          _bandControllerList=bandControllerList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(onPressed: (){
      try{
        final campState=ref.read(campStateNotifierProvider);
        final notifier=ref.read(campStateNotifierProvider.notifier);
        final deletedIndexList=notifier.makeSchedule(campState[_campIndex]);
        for(int i=deletedIndexList.length-1;i>=0;i--){
          for(int j=deletedIndexList[i].length-1;j>=0;j--){
            _bandControllerList[i][deletedIndexList[i][j]+1].dispose(); ///[i][0]はバンド名
            _bandControllerList[i].removeAt(deletedIndexList[i][j]+1);
          }
        }
      }on BandtitleException catch(e){
        print("$e"); //dialogs
        for(int temp in e.emptyTitleIndex){
          print(temp);
        }
      }catch(e){
        print("$e");
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