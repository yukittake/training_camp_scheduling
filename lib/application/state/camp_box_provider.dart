
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:training_camp_scheduling/domain/types/camp.dart';
part 'camp_box_provider.g.dart';

@riverpod
Box<Camp> campBox(CampBoxRef ref){
  return Hive.box<Camp>('CampBox');
}