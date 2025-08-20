import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class UpdateSchedule {
  final CampRepository repo;
  UpdateSchedule(this.repo);

  void call(Camp camp,List<List<Band>> newSchedule){
    for(int i=0;i<newSchedule.length;i++){
      print("----------------");
      for(int j=0;j<newSchedule[i].length;j++){
        print(newSchedule[i][j].bandTitle);
      }
    }
    final newCamp=camp.copyWith();
    newCamp.schedule=newSchedule;
    repo.edit(newCamp);
  }
}