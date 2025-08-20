import 'package:training_camp_scheduling/application/usecases/add_nameless_band.dart';
import 'package:training_camp_scheduling/application/usecases/add_nameless_camp.dart';
import 'package:training_camp_scheduling/application/usecases/add_nameless_member.dart';
import 'package:training_camp_scheduling/application/usecases/delete_band.dart';
import 'package:training_camp_scheduling/application/usecases/delete_camp.dart';
import 'package:training_camp_scheduling/application/usecases/delete_member.dart';
import 'package:training_camp_scheduling/application/usecases/get_camps.dart';
import 'package:training_camp_scheduling/application/usecases/make_schedule.dart';
import 'package:training_camp_scheduling/application/usecases/turn_open_band.dart';
import 'package:training_camp_scheduling/application/usecases/update_band_title.dart';
import 'package:training_camp_scheduling/application/usecases/update_camp_title.dart';
import 'package:training_camp_scheduling/application/usecases/update_member.dart';
import 'package:training_camp_scheduling/application/usecases/update_rooms.dart';
import 'package:training_camp_scheduling/application/usecases/update_schedule.dart';
import 'package:training_camp_scheduling/domain/entities/band.dart';

import 'package:training_camp_scheduling/domain/entities/camp.dart';
import 'package:training_camp_scheduling/presentation/state/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'camp_state.g.dart';

@riverpod
class CampStateNotifier extends _$CampStateNotifier {
  late final GetCamps _getCamps=ref.read(getCampsProvider);
  late final AddNamelessCamp _addNamelessCamp=ref.read(addNamelessCampProvider);
  late final DeleteCamp _deleteCamp=ref.read(deleteCampProvider);
  late final UpdateCampTitle _updateCampTitle=ref.read(updateCampTitleProvider);
  late final AddNamelessBand _addNamelessBand=ref.read(addNamelessBandProvider);
  late final DeleteBand _deleteBand=ref.read(deleteBandProvider);
  late final UpdateBandTitle _updateBandTitle=ref.read(updateBandTitleProvider);
  late final AddNamelessMember _addNamelessMember=ref.read(addNamelessMemberProvider);
  late final DeleteMember _deleteMember=ref.read(deleteMemberProvider);
  late final UpdateMember _updateMember=ref.read(updateMemberProvider);
  late final TurnOpenBand _turnOpenBand=ref.read(turnOpenBandProvider);
  late final UpdateRooms _updateRooms=ref.read(updateRoomsProvider);
  late final UpdateSchedule _updateSchedule=ref.read(updateScheduleProvider);
  late final MakeSchedule _makeSchedule=ref.read(makeScheduleProvider);

  @override
  List<Camp> build() => _getCamps();

  void addNamelessCamp(){
    _addNamelessCamp();
    state=_getCamps();
  }
  void deleteCamp(String id){
    _deleteCamp(id);
    state=_getCamps();
  }
  void updateCampTitle(Camp camp,String newCampTitle){
    _updateCampTitle(camp,newCampTitle);
    state=_getCamps();
  }


  void addNamelessBand(Camp camp){
    _addNamelessBand(camp);
    state=_getCamps();
  }
  void deleteBand(Camp camp,int bandIndex){
    _deleteBand(camp,bandIndex);
    state=_getCamps();
  }
  void updateBandTitle(Camp camp,int bandIndex,String newBandTitle){
    _updateBandTitle(camp,bandIndex,newBandTitle);
    state=_getCamps();
  }


  void addNamelessMember(Camp camp,int bandIndex){
    _addNamelessMember(camp,bandIndex);
    state=_getCamps();
  }
  void deleteMember(Camp camp,int bandIndex,int memberIndex){
    _deleteMember(camp,bandIndex,memberIndex);
    state=_getCamps();
  }
  void updateMember(Camp camp,int bandIndex,int memberIndex,String newMemberName){
    _updateMember(camp,bandIndex,memberIndex,newMemberName);
    state=_getCamps();
  }
  

  void turnOpenBand(Camp camp,int bandIndex){
    _turnOpenBand(camp,bandIndex);
    state=_getCamps();
  }


  void updateRooms(Camp camp,int newRooms){
    _updateRooms(camp,newRooms);
    state=_getCamps();
  }


  void updateSchedule(Camp camp,List<List<Band>> newSchedule){
    _updateSchedule(camp,newSchedule);
    state=_getCamps();
  }
  List<List<int>> makeSchedule(Camp camp){
    final result=_makeSchedule(camp);
    state=_getCamps();
    return result;
  }
}