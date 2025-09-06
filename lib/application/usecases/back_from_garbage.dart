import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';
import 'package:training_camp_scheduling/domain/repositories/garbage_repository.dart';

class BackFromGarbage {
  final CampRepository campRepo;
  final GarbageRepository garbageRepo;
  BackFromGarbage(this.campRepo, this.garbageRepo);

  void call(Camp camp) {
    garbageRepo.delete(camp.id);
    campRepo.edit(camp);
  }
}