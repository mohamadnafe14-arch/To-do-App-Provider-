import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/providers/to_do_provider.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.text, required this.filter});
  final String text;
  final ToDoFilter filter;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context);
    final isSelected = provider.filter == filter;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () => provider.setFilter(filter),
      child: Text(text),
    );
  }
}
