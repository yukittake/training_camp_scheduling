import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class UpdateBandTitle {
  final CampRepository repo;
  UpdateBandTitle(this.repo);

  void call(Camp camp,int bandIndex,String newBandTitle){
    final newCamp=camp.copyWith();
    newCamp.bands[bandIndex].bandTitle=newBandTitle;
    repo.edit(newCamp);
  }
}