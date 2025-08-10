import 'package:hive/hive.dart';
part 'band.g.dart';
@HiveType(typeId: 0)
class Band{
  @HiveField(0)
  String _bandTitle;
  @HiveField(1)
  List<String> _members;
  @HiveField(2)
  bool _open;

  String get bandTitle => _bandTitle;
  List<String> get members => _members;
  bool get open => _open;
  set bandTitle(String s) => _bandTitle=s;
  set members(List<String> lm) => _members=lm;
  set open(bool b) => _open=b;

  Band({String? bandTitle,List<String>? members,bool? open})
    : _bandTitle=bandTitle ?? "",
      _members=members ?? <String>[],
      _open=open ?? true;
}