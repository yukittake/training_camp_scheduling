import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class DeleteMember {
  final CampRepository repo;
  DeleteMember(this.repo);

  void call(Camp camp,int bandIndex,int memberIndex){
    final newCamp=camp.copyWith();
    newCamp.bands[bandIndex].members.removeAt(memberIndex);
    repo.edit(newCamp);
  }
}