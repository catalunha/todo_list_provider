enum TaskFilterEnum {
  today,
  tomorrow,
  week,
}

extension TaskFilterEnumDescription on TaskFilterEnum {
  String get description {
    switch (this) {
      case TaskFilterEnum.today:
        return 'de Hoje';
        break;
      case TaskFilterEnum.tomorrow:
        return 'de Amanha';
        break;
      case TaskFilterEnum.week:
        return 'da Semana';
        break;
    }
  }
}
