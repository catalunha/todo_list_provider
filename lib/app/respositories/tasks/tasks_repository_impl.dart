import 'package:todo_list_provider/app/core/database/hive/hive_connection_factory.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
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
          'finished': true
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(start.year, start.month, start.day, 23, 59, 59);
    final conn = await _hiveConnectionFactory.openConnection();
    final resultTasksMap = await conn.readAll('todo');
    final resultTasksModel =
        resultTasksMap.map((e) => TaskModel.fromMap(e)).toList();
    var filtered = <TaskModel>[];
    for (var task in resultTasksModel) {
      if (task.date.isAfter(startFilter) && task.date.isBefore(endFilter)) {
        filtered.add(task);
      }
    }
    return filtered;
  }
}
