import 'package:hive/hive.dart';
import 'package:training_camp_scheduling/domain/types/band.dart';
import 'package:uuid/uuid.dart';
part 'camp.g.dart';

final Uuid uuid = Uuid();
@HiveType(typeId: 1)
class Camp {
  @HiveField(0)
  String _campTitle;
  @HiveField(1)
  List<Band> _bands;
  @HiveField(2)
  String _id;

  String get campTitle => _campTitle;
  List<Band> get bands => _bands;
  String get id => _id;
  set campTitle(String s) => _campTitle=s;
  set bands(List<Band> lb) => _bands=lb;
  set id(String s) => _id=s;

  Camp({String? campTitle, List<Band>? bands,String? id})
      : _campTitle = campTitle ?? "新規", // campTitleがnullなら"無題"
        _bands = bands ?? <Band>[],       // bandsがnullなら空のリスト
        _id = id ?? uuid.v4();
}