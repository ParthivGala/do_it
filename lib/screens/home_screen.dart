import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:do_it/models/models.dart';
import 'package:do_it/screens/add_task_sheet.dart';
import 'package:do_it/screens/home_screen_tasks_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FileSession providedFileSession = Provider.of<FileSession>(context);
    TaskData providedTaskData = providedFileSession.jsonFileContents;
    try {
      return Scaffold(
        backgroundColor: Colors.red,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color(0xFFE53935),
            foregroundColor: Colors.white,
            elevation: 0.0,
            onPressed: (providedFileSession.jsonFileContents == null)
                ? () {
                    print("No lists");
                  }
                : () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => AddTaskSheet(),
                    );
                  }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 30.0, top: 60.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Icon(
                          Icons.list,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/list_selection');
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    (providedTaskData.taskData[providedTaskData.activeIndex] ==
                            null)
                        ? "No Active List"
                        : providedTaskData
                            .taskData[providedTaskData.activeIndex].listName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    (providedTaskData.taskData[providedTaskData.activeIndex] ==
                            null)
                        ? "Create new list"
                        : '${providedTaskData.taskData[providedTaskData.activeIndex].remainingTasks} of ${providedTaskData.taskData[providedTaskData.activeIndex].tasksList.length} task(s) remaining.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15.0, right: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: TasksList(),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      if (e.runtimeType == NoSuchMethodError) print('Loading file...');
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
