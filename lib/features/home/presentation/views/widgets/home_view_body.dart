import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/providers/to_do_provider.dart';
import 'package:to_do_app/features/home/presentation/views/widgets/filter_button.dart';
import 'package:to_do_app/features/home/presentation/views/widgets/task_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search tasks...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              context.read<ToDoProvider>().setSearchQuery(value);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            FilterButton(filter: ToDoFilter.all, text: 'All'),
            FilterButton(filter: ToDoFilter.completed, text: 'Completed'),
            FilterButton(filter: ToDoFilter.pending, text: 'Pending'),
          ],
        ),
        SizedBox(height: 16.h),
        Consumer<ToDoProvider>(
          builder: (context, provider, child) {
            if (provider.filteredToDoList.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.task_alt, size: 64, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      'No tasks yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: provider.filteredToDoList.length,
                itemBuilder: (context, index) {
                  return TaskItem(toDo: provider.filteredToDoList[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
