import 'package:todo_list_provider/app/core/database/hive/hive_database.dart';
import 'package:synchronized/synchronized.dart';

class HiveConnectionFactory {
  static HiveConnectionFactory? _instance;
  HiveConnectionFactory._();
  factory HiveConnectionFactory() {
    _instance ??= HiveConnectionFactory._();
    return _instance!;
  }

  HiveDatabase? _hiveDatabase;
  final _lock = Lock();

  Future<HiveDatabase> openConnection() async {
    if (_hiveDatabase == null) {
      await _lock.synchronized(() async {
        if (_hiveDatabase == null) {
          print('+++> openConnection HiveDatabase');
          _hiveDatabase = HiveDatabase();
          //print('+++> openConnection HiveDatabase 1');
          await _hiveDatabase!.initInFlutter();
          //print('+++> openConnection HiveDatabase 2');
          await _hiveDatabase!.addBox('todo');
          //print('+++> openConnection HiveDatabase 3');
          var listBoxes = await _hiveDatabase!.listOfBoxes();
          //print('+++> openConnection HiveDatabase 4');
          //print(listBoxes);
          //print('+++> openConnection HiveDatabase 5');
          // onConfigureBoxes();
        }
      });
    }
    print('---> openED Connection ...');
    return _hiveDatabase!;
  }

  // void onConfigureBoxes() async {}

  void closeConnection() {
    _hiveDatabase?.closeAll();
    _hiveDatabase = null;
  }
}
