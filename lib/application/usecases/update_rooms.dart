import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class UpdateRooms {
  final CampRepository repo;
  UpdateRooms(this.repo);

  void call(Camp camp,int newRooms){
    final newCamp=camp.copyWith();
    newCamp.rooms=newRooms;
    repo.edit(newCamp);
  }
}