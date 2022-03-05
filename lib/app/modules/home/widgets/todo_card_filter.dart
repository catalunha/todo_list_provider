import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  const TodoCardFilter(
      {Key? key, required this.label, required this.taskFilter})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.primaryColor,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.8),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: 21,
          //   width: 21,
          //   child: CircularProgressIndicator(),
          // ),
          Text(
            '10 Tasks',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          LinearProgressIndicator(
            backgroundColor: context.primaryColorLight,
            value: .4,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
