import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/providers/to_do_provider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(
      builder: (context, provider, child) {
        if (provider.toDoList.isEmpty) {
          return const Center(
            child: Text(
              'No tasks yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        }
        return ListView.builder(
          itemCount: provider.toDoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Checkbox(
                value: provider.toDoList[index].isCompleted,
                onChanged: (value) {
                  provider.toggleToDoStatus(toDo: provider.toDoList[index]);
                },
              ),
              title: Text(
                provider.toDoList[index].title,
                style: TextStyle(
                  decoration: provider.toDoList[index].isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  provider.removeToDo(provider.toDoList[index]);
                },
              ),
            );
          },
        );
      },
    );
  }
}
