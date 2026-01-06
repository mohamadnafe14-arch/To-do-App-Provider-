import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/models/to_do_model.dart';
import 'package:to_do_app/core/providers/to_do_provider.dart';

class AddTaskScreenBody extends StatefulWidget {
  const AddTaskScreenBody({super.key});
  @override
  State<AddTaskScreenBody> createState() => _AddTaskScreenBodyState();
}

class _AddTaskScreenBodyState extends State<AddTaskScreenBody> {
  late GlobalKey<FormState> formKey;
  String? taskTitle;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) => taskTitle = value,
            onSaved: (newValue) => taskTitle = newValue,
            decoration: InputDecoration(
              labelText: 'Task Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                final toDo = ToDoModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: taskTitle!,
                  isCompleted: false,
                  createdAt: DateTime.now(),
                );
                Provider.of<ToDoProvider>(context, listen: false).addToDo(toDo);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task added successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
                GoRouter.of(context).pop();
              }
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
