import 'dart:io';
import 'dart:convert';
import 'package:do_it/models/models.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  File jsonFile;

  FileHandler() {
    getDataFile();
  }

  Future<void> createDataFile() async {
    print('Creating new file');
    jsonFile.createSync();
    Task task0 = Task(taskTitle: 'Default task');
    TaskList list0 = TaskList(
      listName: 'Do-it ✅',
      tasksList: [task0],
    );
    TaskData datum = TaskData(
      taskData: [list0],
      activeIndex: 0,
    );
    writeTaskData(datum);
  }

  Future<File> getDataFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    print('Directory unlocked');
    String filePath = directory.path + "/appData.json";
    File jsonFile = File(filePath);
    return jsonFile;
  }

  Future<File> getTaskData() async {
    jsonFile = await getDataFile();
    if (jsonFile.existsSync()) {
      print('File exists.');
      print('Input file: ' + jsonFile.readAsStringSync());
      return jsonFile;
    } else {
      print('File does not exist');
      jsonFile.createSync();
      if (jsonFile.existsSync()) {
        return jsonFile;
      }
    }
    print('test');
    return null;
  }

  void writeTaskData(TaskData values) {
    jsonFile.writeAsStringSync(json.encode(values));
    print(jsonEncode(values));
  }
}
