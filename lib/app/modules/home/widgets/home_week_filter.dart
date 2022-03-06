import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
          (value) => value.filterSelected == TaskFilterEnum.week),
      // Mesma construção pegando tudo ou parte
      // visible: context.select<HomeController, TaskFilterEnum>(
      //         (value) => value.filterSelected) ==
      //     TaskFilterEnum.week,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Dia da Semana',
            style: context.titleStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) =>
                  controller.initialDateOfWeek ?? DateTime.now(),
              builder: (_, value, __) {
                return DatePicker(
                  value,
                  locale: 'pt_BR',
                  initialSelectedDate: DateTime.now(),
                  selectionColor: context.primaryColor,
                  daysCount: 7,
                  monthTextStyle: TextStyle(fontSize: 8),
                  dayTextStyle: TextStyle(fontSize: 13),
                  dateTextStyle: TextStyle(fontSize: 13),
                  onDateChange: (date) {
                    context.read<HomeController>().filterByDay(date);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
