import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:do_it/screens/add_list_sheet.dart';
import 'package:do_it/screens/list_selection_listview.dart';
import 'package:do_it/models/models.dart';

import 'add_list_sheet.dart';

class ListSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FileSession providedFileSession = Provider.of<FileSession>(context);
    TaskData providedTaskData = providedFileSession.jsonFileContents;
    List<TaskList> listData = providedTaskData.taskData;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
//        backgroundColor: Color(0xFFE53935),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white54,
          elevation: 0.0,
          onPressed: (providedFileSession.jsonFileContents == null)
              ? () {
                  print("No lists");
                }
              : () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => AddListSheet(),
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
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: Icon(
                        Icons.list,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  '<APP NAME>',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '${providedTaskData.overallCompletion}% task(s) remaining.',
                  style: TextStyle(
                    color: Colors.black,
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
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ListsView(listData: listData),
            ),
          ),
        ],
      ),
    );
  }
}
