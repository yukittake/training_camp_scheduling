import 'package:training_camp_scheduling/infrastructure/hive_classes/hive_band.dart';
import 'package:hive/hive.dart';
part 'hive_camp.g.dart';


@HiveType(typeId: 1)
class HiveCamp {
  @HiveField(0)
  String _campTitle;
  @HiveField(1)
  List<HiveBand> _bands;
  @HiveField(2)
  String _id;
  @HiveField(3)
  List<List<HiveBand>> _schedule;
  @HiveField(4)
  int _rooms;
  @HiveField(5)
  DateTime _createdAt;

  String get campTitle => _campTitle;
  List<HiveBand> get bands => _bands;
  String get id => _id;
  List<List<HiveBand>> get schedule => _schedule;
  int get rooms => _rooms;
  DateTime get createdAt => _createdAt;

  HiveCamp({required campTitle,required bands,required id,required schedule,required rooms,required createdAt})
      : _campTitle = campTitle,
        _bands = bands,
        _id = id,
        _createdAt = createdAt,
        _schedule = schedule,
        _rooms = rooms;
}