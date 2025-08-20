class BandtitleException implements Exception{
  final String _message;
  final List<int> _emptyTitleIndex;
  const BandtitleException(this._message,this._emptyTitleIndex);

  @override
  String toString() => _message;
  List<int> get emptyTitleIndex => _emptyTitleIndex;
}