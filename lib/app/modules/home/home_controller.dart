import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;
  Future<void> deleteAllTasks() async {
    await _tasksService.clearAll();
  }

  Future<void> loadTotalTasks() async {
    var todayTasks = await _tasksService.getToday();
    todayTotalTasks = TotalTasksModel(
        totalTasks: todayTasks.length,
        totalTasksFinished:
            todayTasks.where((element) => element.finished == true).length);
    //print('todayTotalTasks: ${todayTotalTasks}');

    var tomorrowTasks = await _tasksService.getTomorrow();
    tomorrowTotalTasks = TotalTasksModel(
        totalTasks: tomorrowTasks.length,
        totalTasksFinished:
            tomorrowTasks.where((element) => element.finished == true).length);
    //print('tomorrowTotalTasks: ${tomorrowTotalTasks}');

    var weekTasks = await _tasksService.getWeek();
    weekTotalTasks = TotalTasksModel(
        totalTasks: weekTasks.tasks.length,
        totalTasksFinished: weekTasks.tasks
            .where((element) => element.finished == true)
            .length);
    //print('weekTotalTasks: ${weekTotalTasks}');
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks = [];
    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        var weekModel = await _tasksService.getWeek();
        tasks = weekModel.tasks;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;
    hideLoading();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }
}
