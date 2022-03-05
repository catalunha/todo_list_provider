import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:todo_list_provider/app/models/task_model.dart';

class WeekTaskModel {
  final DateTime startDate;
  final DateTime endDate;
  final List<TaskModel> tasks;
  WeekTaskModel({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });

  WeekTaskModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    List<TaskModel>? tasks,
  }) {
    return WeekTaskModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tasks: tasks ?? this.tasks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'tasks': tasks.map((x) => x.toMap()).toList(),
    };
  }

  factory WeekTaskModel.fromMap(Map<String, dynamic> map) {
    return WeekTaskModel(
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      tasks:
          List<TaskModel>.from(map['tasks']?.map((x) => TaskModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeekTaskModel.fromJson(String source) =>
      WeekTaskModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'WeekTaskModel(startDate: $startDate, endDate: $endDate, tasks: $tasks)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeekTaskModel &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        listEquals(other.tasks, tasks);
  }

  @override
  int get hashCode => startDate.hashCode ^ endDate.hashCode ^ tasks.hashCode;
}
