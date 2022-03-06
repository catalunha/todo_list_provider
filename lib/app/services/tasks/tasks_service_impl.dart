import 'package:intl/date_time_patterns.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/respositories/tasks/tasks_repository.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;
  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;
  @override
  Future<void> save(DateTime date, String description) async {
    _tasksRepository.save(date, description);
  }

  @override
  Future<void> clearAll() {
    return _tasksRepository.clearAll();
  }

  @override
  Future<List<TaskModel>> getToday() {
    print('today');
    return _tasksRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    print('getTomorrow');

    var tomorrow = DateTime.now().add(Duration(days: 1));
    return _tasksRepository.findByPeriod(tomorrow, tomorrow);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    print('getWeek');
    var today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;
    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }
    endFilter = startFilter.add(Duration(days: 6));
    print('getWeek $startFilter ');
    print('getWeek $endFilter ');
    final tasks = await _tasksRepository.findByPeriod(startFilter, endFilter);
    return WeekTaskModel(
        startDate: startFilter, endDate: endFilter, tasks: tasks);
  }
}
