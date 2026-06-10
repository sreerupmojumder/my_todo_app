class TaskModel {
  final int? id;
  final String title;
  final bool isCompleted;

  TaskModel({this.id, required this.title, required this.isCompleted});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'isCompleted': isCompleted ? 1 : 0};
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
