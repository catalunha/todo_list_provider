import 'dart:convert';

class TaskModel {
  final String id;
  final String description;
  final DateTime date;
  final bool finished;
  TaskModel({
    required this.id,
    required this.description,
    required this.date,
    required this.finished,
  });

  TaskModel copyWith({
    String? id,
    String? description,
    DateTime? date,
    bool? finished,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      date: date ?? this.date,
      finished: finished ?? this.finished,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'finished': finished,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      finished: map['finished'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(id: $id, description: $description, date: $date, finished: $finished)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.id == id &&
        other.description == description &&
        other.date == date &&
        other.finished == finished;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        date.hashCode ^
        finished.hashCode;
  }
}
