import 'package:hive/hive.dart';
part 'band.g.dart';
@HiveType(typeId: 0)
class Band{
  @HiveField(0)
  String _bandTitle;
  @HiveField(1)
  List<String> _members;

  String get bandTitle => _bandTitle;
  List<String> get members => _members;
  set bandTitle(String s) => _bandTitle=s;
  set members(List<String> lm) => _members=lm;

  Band({String? bandTitle,List<String>? members})
    : _bandTitle=bandTitle ?? "",
      _members=members ?? <String>[];
}