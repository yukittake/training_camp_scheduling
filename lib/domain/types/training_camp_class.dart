class TrainingCamp {
  String _campTitle;
  List<Band> _bands;

  String get campTitle => _campTitle;
  List<Band> get bands => _bands;
  set campTitle(String s) => _campTitle=s;
  set bands(List<Band> lb) => _bands=lb;

  TrainingCamp({String? campTitle, List<Band>? bands})
      : _campTitle = campTitle ?? "新規", // campTitleがnullなら"無題"
        _bands = bands ?? <Band>[];       // bandsがnullなら空のリスト
}

class Band{
  String _bandTitle;
  List<String> _members;

  String get bandTitle => _bandTitle;
  List<String> get members => _members;
  set bandTitle(String s) => _bandTitle=s;
  set mambers(List<String> lm) => _members=lm;

  Band({String? bandTitle,List<String>? members})
    : _bandTitle=bandTitle ?? "バンド名",
      _members=members ?? <String>[];
}