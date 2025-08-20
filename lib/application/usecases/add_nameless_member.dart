import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class AddNamelessMember {
  final CampRepository repo;
  AddNamelessMember(this.repo);

  void call(Camp camp,int bandIndex){
    final newCamp=camp.copyWith();
    newCamp.bands[bandIndex].members.add("");
    repo.edit(newCamp);
  }
}