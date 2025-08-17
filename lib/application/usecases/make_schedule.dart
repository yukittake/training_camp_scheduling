import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/application/state/camp_state.dart';
import 'package:training_camp_scheduling/domain/features/greedy_scheduling.dart';
import 'package:training_camp_scheduling/domain/features/search_empty_member.dart';
import 'package:training_camp_scheduling/domain/features/search_empty_title.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
import 'package:training_camp_scheduling/domain/types/bandtitle_exception.dart';
import 'package:training_camp_scheduling/domain/types/no_bands_exception.dart';

bool makeSchedule(int rooms,List<Band> bands,WidgetRef ref,int campIndex,final List<List<TextEditingController>> bandControllerList){
  bool hasEmptyMember=false;
  if(bands.isEmpty){
    throw NoBandsException("バンドが存在しません");
  }
  final emptyTitleIndex=searchEmptyTitle(bands);
  if(emptyTitleIndex.isNotEmpty){
    throw BandtitleException("バンド名が未記入のものがあります",emptyTitleIndex);
  }

  //空白のメンバーを消す
  final notifier=ref.read(campStateNotifierProvider.notifier);
  List<List<int>> emptyMemberIndex=searchEmptyMember(bands);
  if(emptyMemberIndex.isNotEmpty){
    hasEmptyMember=true;
    for(List<int> emptys in emptyMemberIndex){
      notifier.deleteMember(campIndex, emptys[0], emptys[1]);
      bandControllerList[emptys[0]][emptys[1]+1].dispose();
      bandControllerList[emptys[0]].removeAt(emptys[1]+1);
    }
  }

  //実行
  List<List<Band>> result =greedyScheduling(bands,rooms);
  notifier.updateSchedule(campIndex,result);
  return hasEmptyMember;
}