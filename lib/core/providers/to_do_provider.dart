import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/core/models/to_do_model.dart';
enum ToDoFilter { all, completed, pending }
class ToDoProvider extends ChangeNotifier {
  List<ToDoModel> _toDoList = [];
  List<ToDoModel> get toDoList => _toDoList;
  ToDoFilter _filter = ToDoFilter.all;
  ToDoFilter get filter => _filter;
  int getNextId() {
    return _toDoList.length + 1;
  }
  void setFilter(ToDoFilter filter) {
    _filter = filter;
    notifyListeners();
  }
  List<ToDoModel> get filteredToDoList {
    switch (_filter) {
      case ToDoFilter.completed:
        return _toDoList.where((toDo) => toDo.isCompleted).toList();
      case ToDoFilter.pending:
        return _toDoList.where((toDo) => !toDo.isCompleted).toList();
      case ToDoFilter.all:
      default:
        return _toDoList;
    }
  }
  void _update() {
    var hiveBox = Hive.box<ToDoModel>('toDoBox');
    _toDoList = hiveBox.values.toList();
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

  void toggleToDoStatus({required ToDoModel toDo}) {
    toDo.isCompleted = !toDo.isCompleted;
    toDo.save();
    _update();
  }
}
