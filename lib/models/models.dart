import 'package:do_it/services/fileHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'dart:convert';

part 'models.g.dart';

class FileSession extends ChangeNotifier {
  TaskData jsonFileContents;

  FileHandler fileHandler;
  FileSession() {
    fileHandler = FileHandler();
    fileHandler.getTaskData().then((File file) {
      String td = file.readAsStringSync();
      try {
        print('Decoding json...');
        jsonFileContents = TaskData.fromJson(json.decode(td));
        if (jsonFileContents.taskData.isEmpty) fileHandler.createDataFile();
        notifyListeners();
      } catch (e) {
        print(e);
        if (e.runtimeType == FormatException) fileHandler.createDataFile();
        FileSession();
      }
    });
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void addTask(String taskTitle, TaskList list) {
    list.tasksList.add(Task(taskTitle: taskTitle));
    print(jsonEncode(jsonFileContents));
    fileHandler.writeTaskData(jsonFileContents);
    notifyListeners();
  }

  void deleteTask(int index, TaskList list) {
    list.tasksList.removeAt(index);
    print(jsonEncode(jsonFileContents));
    fileHandler.writeTaskData(jsonFileContents);
    notifyListeners();
  }

  void setActiveList(int index) {
    jsonFileContents.activeIndex = index;
    notifyListeners();
  }

  void addList(String listTitle) {
    print('Initial ' + jsonFileContents.toJson().toString());
    jsonFileContents.taskData.add(TaskList(listName: listTitle, tasksList: []));
    print('Later ' + jsonFileContents.toJson().toString());
    fileHandler.writeTaskData(jsonFileContents);
    notifyListeners();
  }

  void deleteList(int index) {
    if (jsonFileContents.taskData.length != 1) {
      if (jsonFileContents.activeIndex == index) {
        jsonFileContents.activeIndex = (index == 0) ? 0 : (index - 1);
      }
      jsonFileContents.taskData.removeAt(index);
      fileHandler.writeTaskData(jsonFileContents);
      notifyListeners();
    } else {
      print('1');
    }
  }
}

@JsonSerializable()
class TaskData {
  List<TaskList> taskData;
  int activeIndex;

  TaskData({this.taskData, this.activeIndex});

  factory TaskData.fromJson(Map<String, dynamic> json) =>
      _$TaskDataFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDataToJson(this);

  double get overallCompletion {
    int total = 0, complete = 0;
    for (TaskList taskList in taskData) {
      total += taskList.tasksList.length;
      complete += taskList.remainingTasks;
    }
    return (complete / total * 100);
  }
}

@JsonSerializable()
class TaskList {
  String listName;
  List<Task> tasksList;
  //TODO: Add member to identify theme

  TaskList({this.listName, this.tasksList});

  factory TaskList.fromJson(Map<String, dynamic> json) =>
      _$TaskListFromJson(json);

  Map<String, dynamic> toJson() => _$TaskListToJson(this);

  int get remainingTasks {
    int count = tasksList.length;
    for (var task in tasksList) {
      if (task.isDone) count--;
    }
    return count;
  }
}

@JsonSerializable()
class Task {
  String taskTitle;
  bool isDone;

  Task({this.taskTitle, this.isDone = false});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  void toggleDone() => this.isDone = !isDone;
}
