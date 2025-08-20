import 'package:hive/hive.dart';

part 'hive_band.g.dart';

@HiveType(typeId: 0)
class HiveBand {
  @HiveField(0)
  String _bandTitle;
  @HiveField(1)
  List<String> _members;
  @HiveField(2)
  bool _open;

  String get bandTitle => _bandTitle;
  List<String> get members => _members;
  bool get open => _open;

  HiveBand({required bandTitle,required members,required open}):
    _bandTitle=bandTitle,
    _members=members,
    _open=open;
}