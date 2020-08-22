import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:do_it/models/models.dart';

class AddTaskSheet extends StatelessWidget {
  static String taskTitle;

  @override
  Widget build(BuildContext context) {
    FileSession providedFileSession = Provider.of<FileSession>(context);
    TaskList providedTaskList = providedFileSession.jsonFileContents
        .taskData[providedFileSession.jsonFileContents.activeIndex];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Color(0xFF757575),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25.0),
              topLeft: Radius.circular(25.0),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'New Task',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFE53935),
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            taskTitle = value;
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'Add task',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            providedFileSession.addTask(
                                taskTitle, providedTaskList);
                            Navigator.pop(context);
                          },
                          color: Color(0xC0E53935),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
