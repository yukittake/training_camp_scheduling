import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/application/state/camp_state.dart';
import 'package:training_camp_scheduling/presentation/pages/second_page.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
import 'package:training_camp_scheduling/presentation/theme/fonts.dart';

class MyHomePage extends ConsumerWidget{
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final campState=ref.watch(campStateNotifierProvider);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        title: Text("ホーム",style:AppText.title),
        actions: [IconButton(onPressed: (){
          final notifier=ref.read(campStateNotifierProvider.notifier);
          notifier.addCamp();
        }, icon: Icon(Icons.add_circle,size: 45,color: AppColor.black,))],  
      ),
      body: ListView.separated(
        itemCount: campState.length,
        itemBuilder: (BuildContext context, int index) {
          final reversedIndex = campState.length - 1 - index;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onHorizontalDragEnd: (details){
                  final notifier=ref.read(campStateNotifierProvider.notifier);
                  if (details.velocity.pixelsPerSecond.dx < 0){
                    notifier.deleteCamp(reversedIndex);
                  }
                },
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage(index:reversedIndex)),
                );
                },
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color:AppColor.shadowLight),
                        BoxShadow(offset:Offset(0, 3),color:AppColor.greyBack,spreadRadius: -2,blurRadius: 5)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    width: 400,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left:18,top: 13),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:40,right: 15),
                        child: Text(campState[reversedIndex].campTitle,style:AppText.subTitle),
                      ),
                    ),
                  ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int reversedIndex) =>
            Container(height: 15, color: AppColor.white)
      ),
    );
  }
}
