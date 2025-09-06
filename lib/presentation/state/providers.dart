import 'package:training_camp_scheduling/application/usecases/add_nameless_band.dart';
import 'package:training_camp_scheduling/application/usecases/add_nameless_camp.dart';
import 'package:training_camp_scheduling/application/usecases/add_nameless_member.dart';
import 'package:training_camp_scheduling/application/usecases/back_from_garbage.dart';
import 'package:training_camp_scheduling/application/usecases/completely_delete_camp.dart';
import 'package:training_camp_scheduling/application/usecases/delete_band.dart';
import 'package:training_camp_scheduling/application/usecases/delete_camp.dart';
import 'package:training_camp_scheduling/application/usecases/delete_member.dart';
import 'package:training_camp_scheduling/application/usecases/get_camps.dart';
import 'package:training_camp_scheduling/application/usecases/get_garbage.dart';
import 'package:training_camp_scheduling/application/usecases/make_schedule.dart';
import 'package:training_camp_scheduling/application/usecases/turn_open_band.dart';
import 'package:training_camp_scheduling/application/usecases/update_band_title.dart';
import 'package:training_camp_scheduling/application/usecases/update_camp_title.dart';
import 'package:training_camp_scheduling/application/usecases/update_member.dart';
import 'package:training_camp_scheduling/application/usecases/update_rooms.dart';
import 'package:training_camp_scheduling/application/usecases/update_schedule.dart';
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';
import 'package:training_camp_scheduling/domain/repositories/garbage_repository.dart';
import 'package:training_camp_scheduling/infrastructure/camp_repository_impl.dart';
import 'package:training_camp_scheduling/infrastructure/garbage_data_source.dart';
import 'package:training_camp_scheduling/infrastructure/hive_camp_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:training_camp_scheduling/infrastructure/hive_garbage_data_source.dart';

final _dsProvider = Provider<HiveCampDataSource>((ref) => HiveCampDataSource());
final _gdsProvider = Provider<HiveGarbageDataSource>((ref) => HiveGarbageDataSource());
final campRepositoryProvider = Provider<CampRepository>(
  (ref) => CampRepositoryImpl(ref.watch(_dsProvider)),
);
final garbageRepositoryProvider = Provider<GarbageRepository>(
  (ref) => GarbageRepositoryImpl(ref.watch(_gdsProvider)),
);


final getCampsProvider = Provider((ref) => GetCamps(ref.watch(campRepositoryProvider)));
final addNamelessCampProvider = Provider((ref) => AddNamelessCamp(ref.watch(campRepositoryProvider)));
final deleteCampProvider = Provider((ref) => DeleteCamp(ref.watch(campRepositoryProvider),ref.watch(garbageRepositoryProvider)));
final updateCampTitleProvider = Provider((ref) => UpdateCampTitle(ref.watch(campRepositoryProvider)));
final addNamelessBandProvider = Provider((ref) => AddNamelessBand(ref.watch(campRepositoryProvider)));
final deleteBandProvider = Provider((ref) => DeleteBand(ref.watch(campRepositoryProvider)));
final updateBandTitleProvider = Provider((ref) => UpdateBandTitle(ref.watch(campRepositoryProvider)));
final addNamelessMemberProvider = Provider((ref) => AddNamelessMember(ref.watch(campRepositoryProvider)));
final deleteMemberProvider = Provider((ref) => DeleteMember(ref.watch(campRepositoryProvider)));
final updateMemberProvider = Provider((ref) => UpdateMember(ref.watch(campRepositoryProvider)));
final turnOpenBandProvider = Provider((ref) => TurnOpenBand(ref.watch(campRepositoryProvider)));
final updateRoomsProvider = Provider((ref) => UpdateRooms(ref.watch(campRepositoryProvider)));
final updateScheduleProvider = Provider((ref) => UpdateSchedule(ref.watch(campRepositoryProvider)));
final makeScheduleProvider = Provider((ref) => MakeSchedule(ref.watch(campRepositoryProvider)));


final completelyDeleteCampProvider = Provider((ref) => CompletelyDeleteCamp(ref.watch(garbageRepositoryProvider)));
final getGarbageProvider = Provider((ref) => GetGarbage(ref.watch(garbageRepositoryProvider)));
final backFromGarbageProvider = Provider((ref) => BackFromGarbage(ref.watch(campRepositoryProvider),ref.watch(garbageRepositoryProvider)));