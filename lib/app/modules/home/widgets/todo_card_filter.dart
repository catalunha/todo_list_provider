import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;
  final bool selected;
  const TodoCardFilter({
    Key? key,
    required this.label,
    required this.taskFilter,
    this.totalTasksModel,
    required this.selected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeController>().findTasks(filter: taskFilter);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 120,
          maxWidth: 150,
        ),
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
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
              '${totalTasksModel?.totalTasks ?? 0} Tasks',
              style: context.titleStyle.copyWith(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: _getPercentFinish()),
              duration: Duration(seconds: 1),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  // backgroundColor: context.primaryColorLight,
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  double _getPercentFinish() {
    var result = 0.0;
    final total = totalTasksModel?.totalTasks ?? 0;
    final totalFinish = totalTasksModel?.totalTasksFinished ?? 0;
    if (total > 0) {
      result = totalFinish / total;
    }
    return result;
  }
}
