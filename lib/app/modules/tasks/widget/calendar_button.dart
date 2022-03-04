import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/tasks/task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/y');
  CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(lastDate.year),
          lastDate: DateTime(lastDate.year + 1),
        );
        context.read<TaskCreateController>().selectedDate = selectedDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.today,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Selector<TaskCreateController, DateTime?>(
                builder: (context, selectedDate, child) {
                  if (selectedDate != null) {
                    return Text(dateFormat.format(selectedDate),
                        style: context.titleStyle);
                  } else {
                    return Text('Selecione uma data',
                        style: context.titleStyle);
                  }
                },
                selector: (context, controller) => controller.selectedDate),
          ],
        ),
      ),
    );
  }
}
