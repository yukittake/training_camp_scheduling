import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';

class SchedulingButton extends ConsumerWidget {
  const SchedulingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(onPressed: (){},style:FilledButton.styleFrom(backgroundColor: AppColor.lightBlue,textStyle: AppText.smallWhite,),
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


// if(index==0){
//               return Column(children: [
//                 ElevatedButton(onPressed: (){
//                   final campList=ref.read(campStateNotifierProvider);
//                   List<List<Band>> result =greedyScheduling(campList[widget.index].bands, 5);
//                   for(List<Band> bandList in result){
//                     print("--------------");
//                     for(Band tempBand in bandList){
//                       print("${tempBand.bandTitle}");
//                     }
//                   }
//                 }, child: Text("作成開始/空白、未入力未対応")),
//                 SizedBox(width: double.infinity,height:300,child: Placeholder(),),
//               ],);
//             }