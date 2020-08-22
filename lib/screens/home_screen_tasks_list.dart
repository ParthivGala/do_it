import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:do_it/models/models.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FileSession providedFileSession = Provider.of<FileSession>(context);
    TaskList providedTaskList = providedFileSession.jsonFileContents
        .taskData[providedFileSession.jsonFileContents.activeIndex];

    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(
          todoTask: providedTaskList.tasksList[index],
          checkboxCallback: (value) {
            providedFileSession.updateTask(providedTaskList.tasksList[index]);
          },
          onLongPressCallback: () {
            providedFileSession.deleteTask(index, providedTaskList);
          },
          onTapCallback: () {
            providedFileSession.updateTask(providedTaskList.tasksList[index]);
          },
        );
      },
      itemCount: providedTaskList.tasksList.length,
    );
  }
}

class TaskTile extends StatelessWidget {
  TaskTile(
      {this.todoTask,
      this.checkboxCallback,
      this.onLongPressCallback,
      this.onTapCallback});

  final Task todoTask;
  final Function checkboxCallback;
  final Function onLongPressCallback;
  final Function onTapCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todoTask.taskTitle,
        style: TextStyle(
            decoration: todoTask.isDone ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: todoTask.isDone,
        onChanged: checkboxCallback,
      ),
      onLongPress: onLongPressCallback,
      onTap: onTapCallback,
    );
  }
}
