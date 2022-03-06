import 'dart:convert';

class TotalTasksModel {
  final int totalTasks;
  final int totalTasksFinished;

  TotalTasksModel({
    required this.totalTasks,
    required this.totalTasksFinished,
  });

  TotalTasksModel copyWith({
    int? totalTasks,
    int? totalTasksFinished,
  }) {
    return TotalTasksModel(
      totalTasks: totalTasks ?? this.totalTasks,
      totalTasksFinished: totalTasksFinished ?? this.totalTasksFinished,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalTasks': totalTasks,
      'totalTasksFinished': totalTasksFinished,
    };
  }

  factory TotalTasksModel.fromMap(Map<String, dynamic> map) {
    return TotalTasksModel(
      totalTasks: map['totalTasks']?.toInt() ?? 0,
      totalTasksFinished: map['totalTasksFinished']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TotalTasksModel.fromJson(String source) =>
      TotalTasksModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'TotalTasksModel(totalTasks: $totalTasks, totalTasksFinished: $totalTasksFinished)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TotalTasksModel &&
        other.totalTasks == totalTasks &&
        other.totalTasksFinished == totalTasksFinished;
  }

  @override
  int get hashCode => totalTasks.hashCode ^ totalTasksFinished.hashCode;
}
