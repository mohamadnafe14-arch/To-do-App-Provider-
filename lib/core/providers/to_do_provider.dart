import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/core/models/to_do_model.dart';

enum ToDoFilter { all, completed, pending }

class ToDoProvider extends ChangeNotifier {
String _searchQuery = '';
  String get searchQuery => _searchQuery;
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
  List<ToDoModel> _toDoList = [];
  List<ToDoModel> get toDoList => _toDoList;
  ToDoFilter _filter = ToDoFilter.all;
  ToDoFilter get filter => _filter;
  

  ToDoProvider() {
    _update();
  }
  void setFilter(ToDoFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  List<ToDoModel> get filteredToDoList {
    List<ToDoModel> filteredList=[];
    switch (_filter) {
      case ToDoFilter.completed:
        filteredList = _toDoList.where((toDo) => toDo.isCompleted).toList();
        break;
      case ToDoFilter.pending:
        filteredList = _toDoList.where((toDo) => !toDo.isCompleted).toList();
        break;
      case ToDoFilter.all:
      filteredList = _toDoList;
    }
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList
          .where((toDo) =>
              toDo.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return filteredList;
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
