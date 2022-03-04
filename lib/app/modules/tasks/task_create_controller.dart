import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/tasks/tasks_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TasksService _taskService;
  DateTime? _selectedDate;
  TaskCreateController({required TasksService taskService})
      : _taskService = taskService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      print(_selectedDate);
      if (_selectedDate != null) {
        await _taskService.save(_selectedDate!, description);
        success();
      } else {
        setError('Selecione uma data');
      }
    } catch (e) {
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
