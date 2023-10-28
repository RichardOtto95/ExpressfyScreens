import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store implements Disposable {
  @override
  void dispose() {
    calendarController.dispose();
  }

  @observable
  CalendarController calendarController = CalendarController();
  @observable
  bool isEmpty = false;
}
