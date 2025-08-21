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
    final campState=ref.watch(campStateNotifierProvider);
    return FilledButton(onPressed: (){
      try{
        final notifier=ref.read(campStateNotifierProvider.notifier);
        final emptyMemberFlag=campState[_campIndex].hasEmptyMember();
        final deletedIndexList=notifier.makeSchedule(campState[_campIndex]);
        for(int i=deletedIndexList.length-1;i>=0;i--){
          for(int j=deletedIndexList[i].length-1;j>=0;j--){
            _bandControllerList[i][deletedIndexList[i][j]+1].dispose(); ///[i][0]はバンド名
            _bandControllerList[i].removeAt(deletedIndexList[i][j]+1);
          }
        }
        if(emptyMemberFlag) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("空白のメンバーを削除しました"),backgroundColor: AppColor.green,behavior: SnackBarBehavior.floating,duration: Duration(seconds: 2),));
      }on BandtitleException catch(e){
        for(int temp in e.emptyTitleIndex){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${temp+1}番目： $e",style: AppText.white,),backgroundColor: AppColor.red,behavior: SnackBarBehavior.floating,duration: Duration(seconds: 2),));
        }
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),style: AppText.white,),backgroundColor: AppColor.red,behavior: SnackBarBehavior.floating,duration: Duration(seconds: 2),));
      }
    },style:FilledButton.styleFrom(
        backgroundColor: AppColor.lightBlue,
        textStyle: AppText.smallWhite,
        minimumSize: Size.zero, 
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact, 
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          campState[_campIndex].schedule.isEmpty ? Icon(Icons.edit,size: 17,) : Icon(Icons.autorenew,size: 17,),
          SizedBox(width: 10,),
          campState[_campIndex].schedule.isEmpty ? const Text('スケジュール作成') : const Text('スケジュール更新'),
        ],
      ),
    );
  }
}