import 'package:training_camp_scheduling/application/usecases/delete_member.dart';
import 'package:training_camp_scheduling/application/usecases/update_schedule.dart';
import 'package:training_camp_scheduling/domain/entities/band.dart';
import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/domain/entities/exception_bandtitle.dart';
import 'package:training_camp_scheduling/domain/entities/exception_no_bands.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';

class MakeSchedule {
  final CampRepository repo;
  MakeSchedule(this.repo);

  List<List<int>> call(Camp camp){
    final newCamp=camp.copyWith();
    if(camp.bands.isEmpty){
      throw NoBandsException("バンドが存在しません");
    }
    final emptyBandTitleIndex=camp.emptyBandTitleIndex();
    if(emptyBandTitleIndex.isNotEmpty){
      throw BandtitleException("バンド名が未入力です",emptyBandTitleIndex);
    }

    //空白のメンバーを消す
    List<List<int>> emptyMemberIndex=camp.emptyMemberIndex();
    final deleteMember=DeleteMember(repo);
    if(emptyMemberIndex.isNotEmpty){
      for(int i=emptyMemberIndex.length-1;i>=0;i--){ //一個消したらずれる？
        for(int j=emptyMemberIndex[i].length-1;j>=0;j--){
          deleteMember(camp,i,emptyMemberIndex[i][j]);
          newCamp.bands[i].members.removeAt(emptyMemberIndex[i][j]);
        }
      }
    }

    //実装
    List<List<Band>> result =newCamp.greedyScheduling();
    final updateSchedule=UpdateSchedule(repo);
    updateSchedule(newCamp,result);
    return emptyMemberIndex; //消したbandindexとmemberindexがわかるようにreturn 
  }
}