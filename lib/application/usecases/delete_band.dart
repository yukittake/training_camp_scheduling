import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class DeleteBand {
  final CampRepository repo;
  DeleteBand(this.repo);

  void call(Camp camp,int bandIndex){
    final newCamp=camp.copyWith();
    newCamp.bands.removeAt(bandIndex);
    repo.edit(newCamp);
  }
}