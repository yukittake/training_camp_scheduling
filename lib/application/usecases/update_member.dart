import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class UpdateMember {
  final CampRepository repo;
  UpdateMember(this.repo);

  void call(Camp camp,int bandIndex,int memberIndex,String newMemberName){
    final newCamp=camp.copyWith();
    newCamp.bands[bandIndex].members[memberIndex]=newMemberName;
    repo.edit(newCamp);
  }
}