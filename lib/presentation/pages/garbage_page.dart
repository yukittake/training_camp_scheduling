import 'package:flutter/cupertino.dart';
import 'package:training_camp_scheduling/presentation/pages/home_page.dart';
import 'package:training_camp_scheduling/presentation/state/garbage_state.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/presentation/widgets/delete_action_sheet.dart';
import 'package:training_camp_scheduling/presentation/widgets/restore_action_sheet.dart';
class GarbagePage extends ConsumerWidget{
  const GarbagePage({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final garbageState=ref.watch(garbageStateNotifierProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        title: Align(
          alignment: Alignment.centerRight,
          child: SizedBox(width: 110,child: IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          }, icon: Row(children: [Text("ホーム",style: AppText.subTitle,),Icon(Icons.arrow_forward_ios),],))),
        ),
      ),
      body:
      ListView.separated(
        itemCount: garbageState.length+1, //+1は"ゴミ箱"表示用
        itemBuilder: (BuildContext context, int index) {
          final reversedIndex = garbageState.length - index;
          if(index==0){
            return Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ゴミ箱",style:AppText.title),
                  IconButton(onPressed: (){
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (BuildContext context){
                        List<int> list = List.generate(garbageState.length, (i) => garbageState.length - i - 1);
                        return DeleteActionSheet(selectedIndices: list,text:"${list.length}件すべてを完全に削除しますか？",);
                      }
                    );
                  }, icon: Icon(Icons.delete_forever_outlined,size: 35,)),
                ],
              ),
            );
          }
          return Align(
          child: 
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Dismissible(
                key:ValueKey(garbageState[reversedIndex].id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  final flag = await showCupertinoModalPopup(
                    context: context, 
                    builder: (BuildContext context){
                      return DeleteActionSheet(selectedIndices: [reversedIndex],text:"選択した1件を完全に削除しますか？");
                    }
                  );
                  return flag;
                },
                background: Container(
                      decoration: BoxDecoration(
                        color: AppColor.red,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      width: MediaQuery.of(context).size.width*0.94,
                      height: 80,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete,color:AppColor.white)
                    ),
                child: GestureDetector(
                  onTap: () async{
                    final flag = await showCupertinoModalPopup(
                    context: context, 
                    builder: (BuildContext context){
                      return RestoreActionSheet(selectedIndices: [reversedIndex],text:"選択した1件を復元しますか？");
                    }
                    );
                    return flag;
                  },
                  child: Container(
                      color: AppColor.red,
                      width: MediaQuery.of(context).size.width*0.94,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color:AppColor.shadowDeep),
                              BoxShadow(offset:Offset(0, 3),color:AppColor.greyBack,spreadRadius: -2,blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:18,top: 13,bottom:40,right: 15),
                            child: Text(garbageState[reversedIndex].campTitle,style:AppText.subTitle),
                          ),
                        ),
                      ),
                    ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int reversedIndex) =>
            Container(height: 15, color: AppColor.white)
      ),
    );
  }
}
