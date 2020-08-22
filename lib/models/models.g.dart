// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskData _$TaskDataFromJson(Map<String, dynamic> json) {
  return TaskData(
    taskData: (json['taskData'] as List)
        ?.map((e) =>
            e == null ? null : TaskList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    activeIndex: json['activeIndex'] as int,
  );
}

Map<String, dynamic> _$TaskDataToJson(TaskData instance) => <String, dynamic>{
      'taskData': instance.taskData,
      'activeIndex': instance.activeIndex,
    };

TaskList _$TaskListFromJson(Map<String, dynamic> json) {
  return TaskList(
    listName: json['listName'] as String,
    tasksList: (json['tasksList'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TaskListToJson(TaskList instance) => <String, dynamic>{
      'listName': instance.listName,
      'tasksList': instance.tasksList,
    };

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    taskTitle: json['taskTitle'] as String,
    isDone: json['isDone'] as bool,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'taskTitle': instance.taskTitle,
      'isDone': instance.isDone,
    };
