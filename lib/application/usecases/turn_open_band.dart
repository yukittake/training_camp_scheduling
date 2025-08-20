import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class TurnOpenBand {
  final CampRepository repo;
  TurnOpenBand(this.repo);

  void call(Camp camp,int bandIndex){
    final newCamp=camp.copyWith();
    newCamp.bands[bandIndex].open=!newCamp.bands[bandIndex].open;
    repo.edit(newCamp);
  }
}