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
import 'package:training_camp_scheduling/domain/repositories/camp_repository.dart';
import 'package:training_camp_scheduling/infrastructure/camp_repository_impl.dart';
import 'package:training_camp_scheduling/infrastructure/hive_camp_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _dsProvider = Provider<HiveCampDataSource>((ref) => HiveCampDataSource());
final todoRepositoryProvider = Provider<CampRepository>(
  (ref) => CampRepositoryImpl(ref.watch(_dsProvider)),
);


final getCampsProvider = Provider((ref) => GetCamps(ref.watch(todoRepositoryProvider)));
final addNamelessCampProvider = Provider((ref) => AddNamelessCamp(ref.watch(todoRepositoryProvider)));
final deleteCampProvider = Provider((ref) => DeleteCamp(ref.watch(todoRepositoryProvider)));
final updateCampTitleProvider = Provider((ref) => UpdateCampTitle(ref.watch(todoRepositoryProvider)));
final addNamelessBandProvider = Provider((ref) => AddNamelessBand(ref.watch(todoRepositoryProvider)));
final deleteBandProvider = Provider((ref) => DeleteBand(ref.watch(todoRepositoryProvider)));
final updateBandTitleProvider = Provider((ref) => UpdateBandTitle(ref.watch(todoRepositoryProvider)));
final addNamelessMemberProvider = Provider((ref) => AddNamelessMember(ref.watch(todoRepositoryProvider)));
final deleteMemberProvider = Provider((ref) => DeleteMember(ref.watch(todoRepositoryProvider)));
final updateMemberProvider = Provider((ref) => UpdateMember(ref.watch(todoRepositoryProvider)));
final turnOpenBandProvider = Provider((ref) => TurnOpenBand(ref.watch(todoRepositoryProvider)));
final updateRoomsProvider = Provider((ref) => UpdateRooms(ref.watch(todoRepositoryProvider)));
final updateScheduleProvider = Provider((ref) => UpdateSchedule(ref.watch(todoRepositoryProvider)));
final makeScheduleProvider = Provider((ref) => MakeSchedule(ref.watch(todoRepositoryProvider)));