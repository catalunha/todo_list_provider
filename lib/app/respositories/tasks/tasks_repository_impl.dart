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
    //print('Save: TasksRepositoryImpl');
    //print({'date': date, 'description': description, 'finished': true});

    final conn = await _hiveConnectionFactory.openConnection();
    try {
      await conn.create(
        boxName: 'todo',
        data: {'date': date, 'description': description, 'finished': false},
      );
    } catch (e) {
      //print(e);
    }
  }

  @override
  Future<void> clearAll() async {
    final conn = await _hiveConnectionFactory.openConnection();
    await conn.deleteAll('todo');
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);
    final conn = await _hiveConnectionFactory.openConnection();
    final resultTasksMap = await conn.readAll('todo');
    //print('findByPeriod');
    //print(resultTasksMap);
    final resultTasksModel =
        resultTasksMap.map((e) => TaskModel.fromMap(e)).toList();
    var filtered = <TaskModel>[];
    for (var task in resultTasksModel) {
      //print(task);
      if (task.date.isAtSameMomentAs(startFilter) ||
          task.date.isAtSameMomentAs(endFilter)) {
        filtered.add(task);
      } else if (task.date.isAfter(startFilter) &&
          task.date.isBefore(endFilter)) {
        filtered.add(task);
      }
      //print(filtered);
    }
    return filtered;
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) async {
    final conn = await _hiveConnectionFactory.openConnection();
    await conn.update(boxName: 'todo', data: task.toMap());
  }
}
