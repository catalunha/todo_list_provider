class SqliteConnFactory {
  static SqliteConnFactory? _instance;
  SqliteConnFactory._();
  factory SqliteConnFactory() {
    _instance ??= SqliteConnFactory._();
    return _instance!;
  }
}
