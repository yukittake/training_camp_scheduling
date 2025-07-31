import 'package:training_camp_scheduling/domain/types/band.dart';

List<List<Band>> greedyScheduling(List<Band> bands,int n){
  Set<int> usedIndex = {};
  List<List<Band>> result=[];

  while(usedIndex.length < bands.length){
    List<Band> currentGroup=[];
    Set<String> usedPeople={};

    for(int i=0;i<bands.length;i++){
      if(usedIndex.contains(i)) continue;
      if(bands[i].members.toSet().intersection(usedPeople).isEmpty){
        currentGroup.add(bands[i]);
        usedIndex.add(i);
        usedPeople.addAll(bands[i].members);
      }

      if(currentGroup.length == n) break;
    }

    result.add(currentGroup);
  }
  return result;
}