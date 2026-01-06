import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/core/models/to_do_model.dart';

class ToDoProvider extends ChangeNotifier {
  List<ToDoModel> toDoList = [];
  int getNextId() {
    return toDoList.length + 1;
  }
  void _update() {
    var hiveBox = Hive.box<ToDoModel>('toDoBox');
    toDoList = hiveBox.values.toList();
    notifyListeners();
  }

  void addToDo(ToDoModel toDo) async {
    var hiveBox = Hive.box<ToDoModel>('toDoBox');
    await hiveBox.add(toDo);
    _update();
  }

  void removeToDo(ToDoModel toDo) {
    toDo.delete();
    _update();
  }

  void updateToDoStatus({
    required ToDoModel toDo,
    required bool isCompleted,
    required String title,
    required String description,
  }) {
    toDo.isCompleted = isCompleted;
    toDo.title = title;
    toDo.save();
    _update();
  }

  void toggleToDoStatus({required ToDoModel toDo}) {
    toDo.isCompleted = !toDo.isCompleted;
    toDo.save();
    _update();
  }
}
