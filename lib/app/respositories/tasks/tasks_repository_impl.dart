import 'package:todo_list_provider/app/core/database/hive/hive_connection_factory.dart';
import 'package:todo_list_provider/app/respositories/tasks/tasks_repository.dart';

/*
create table todo(
  id, autoincrement
  descricao, text
  data_hora, datetime
  finalizado integer
)
*/

class TasksRepositoryImpl implements TasksRepository {
  final HiveConnectionFactory _hiveConnectionFactory;
  TasksRepositoryImpl({required HiveConnectionFactory hiveConnectionFactory})
      : _hiveConnectionFactory = hiveConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    print('Save: TasksRepositoryImpl');
    final conn = await _hiveConnectionFactory.openConnection();
    try {
      await conn.create(
        boxName: 'todo',
        data: {
          'date': date.toIso8601String(),
          'description': description,
          'finished': 0
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
