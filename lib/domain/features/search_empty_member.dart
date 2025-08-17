import 'package:training_camp_scheduling/domain/types/band.dart';

List<List<int>> searchEmptyMember(List<Band> bands){
  List<List<int>> result=[];
  for(int i=0;i<bands.length;i++){
    for(int j=0;j<bands[i].members.length;j++){
      if(bands[i].members[j].trim().isEmpty) result.add([i,j]);
    }
  }
  return result;
}