import 'package:flutter/material.dart';
import 'package:do_it/models/models.dart';
import 'package:provider/provider.dart';

class ListsView extends StatelessWidget {
  const ListsView({@required this.listData});

  final List<TaskList> listData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            listData[index].listName,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          trailing: Text(
              '${listData[index].remainingTasks}/${listData[index].tasksList.length}'),
          onTap: () {
            Provider.of<FileSession>(context, listen: false)
                .setActiveList(index);
            Navigator.pop(context);
          },
          onLongPress: () {
            Provider.of<FileSession>(context, listen: false).deleteList(index);
            Navigator.pop(context);
          },
        );
      },
      itemCount: (listData == null) ? 0 : listData.length,
    );
  }
}
