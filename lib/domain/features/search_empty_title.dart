import 'package:training_camp_scheduling/domain/types/band.dart';

List<int> searchEmptyTitle(List<Band> bands){
  List<int> result=[];
  for(int i=0;i<bands.length;i++){
    if(bands[i].bandTitle=="") result.add(i);
  }
  return result;
}