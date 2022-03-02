import 'package:flutter/cupertino.dart';

class Messages {
  final BuildContext context;
  Messages._(this.context);
  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }
}
