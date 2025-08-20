import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class AddNamelessBand {
  final CampRepository repo;
  AddNamelessBand(this.repo);

  void call(Camp camp){
    final newCamp=camp.copyWith();
    newCamp.bands.add(Band(bandTitle: "",members: <String>[],open: true));
    repo.edit(newCamp);
  }
}