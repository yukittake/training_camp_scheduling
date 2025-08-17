class NoBandsException implements Exception{
  final String _message;
  const NoBandsException(this._message);

  @override
  String toString() => _message;
}