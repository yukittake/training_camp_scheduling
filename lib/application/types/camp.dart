import 'package:hive/hive.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
part 'camp.g.dart';


@HiveType(typeId: 1)
class Camp {
  @HiveField(0)
  String _campTitle;
  @HiveField(1)
  List<Band> _bands;

  String get campTitle => _campTitle;
  List<Band> get bands => _bands;
  set campTitle(String s) => _campTitle=s;
  set bands(List<Band> lb) => _bands=lb;

  Camp({String? campTitle, List<Band>? bands})
      : _campTitle = campTitle ?? "新規", // campTitleがnullなら"無題"
        _bands = bands ?? <Band>[];       // bandsがnullなら空のリスト
}