import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class UpdateCampTitle {
  final CampRepository repo;
  UpdateCampTitle(this.repo);

  void call(Camp camp,String newCampTitle){
    final newCamp=camp.copyWith();
    newCamp.campTitle=newCampTitle;
    repo.edit(newCamp);
  }
}