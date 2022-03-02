import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:path/path.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  DefaultChangeNotifier changeNotifier;
  DefaultListenerNotifier({
    required this.changeNotifier,
  });
  void listener({
    required BuildContext context,
    required SucessVoidCallback sucessVoidCallback,
    ErrorVoidCallback? errorVoidCallback,
    EverVoidCallback? everVoidCallback,
  }) {
    changeNotifier.addListener(() {
      if (everVoidCallback != null) {
        everVoidCallback(changeNotifier, this);
      }
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }
      if (changeNotifier.hasError) {
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
        if (errorVoidCallback != null) {
          errorVoidCallback(changeNotifier, this);
        }
      }
      if (changeNotifier.isSuccess) {
        sucessVoidCallback(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SucessVoidCallback = void Function(
  DefaultChangeNotifier changeNotifier,
  DefaultListenerNotifier listenerInstance,
);
typedef ErrorVoidCallback = void Function(
  DefaultChangeNotifier changeNotifier,
  DefaultListenerNotifier listenerInstance,
);
typedef EverVoidCallback = void Function(
  DefaultChangeNotifier changeNotifier,
  DefaultListenerNotifier listenerInstance,
);
