import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';

class HomeFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtros',
          style: context.titleStyle,
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TodoCardFilter(
                label: 'Hoje',
                taskFilter: TaskFilterEnum.today,
              ),
              TodoCardFilter(
                label: 'Amanha',
                taskFilter: TaskFilterEnum.tomorrow,
              ),
              TodoCardFilter(
                label: 'Semana',
                taskFilter: TaskFilterEnum.week,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
