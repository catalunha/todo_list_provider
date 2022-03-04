import 'package:todo_list_provider/app/core/database/hive/hive_controller.dart';
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
  final HiveController _hiveController;
  TasksRepositoryImpl({required HiveController hiveController})
      : _hiveController = hiveController;
  @override
  Future<void> save(DateTime date, String description) async {
    print('Save: TasksRepositoryImpl');
    await _hiveController.addBox('todo');

    await _hiveController.create(
      boxName: 'todo',
      data: {
        'date': date.toIso8601String(),
        'description': description,
        'finished': 0
      },
    );
  }
}
