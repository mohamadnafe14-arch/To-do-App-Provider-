import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/models/to_do_model.dart';
import 'package:to_do_app/core/providers/to_do_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.toDo});
  final ToDoModel toDo;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Checkbox(
          value: toDo.isCompleted,
          onChanged: (_) {
            provider.toggleToDoStatus(toDo: toDo);
          },
        ),
        title: Text(
          toDo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration:
                toDo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            provider.removeToDo(toDo);
          },
        ),
      ),
    );
  }
}
