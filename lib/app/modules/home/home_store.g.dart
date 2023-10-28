// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  final _$calendarControllerAtom =
      Atom(name: '_HomeStoreBase.calendarController');

  @override
  CalendarController get calendarController {
    _$calendarControllerAtom.reportRead();
    return super.calendarController;
  }

  @override
  set calendarController(CalendarController value) {
    _$calendarControllerAtom.reportWrite(value, super.calendarController, () {
      super.calendarController = value;
    });
  }

  final _$isEmptyAtom = Atom(name: '_HomeStoreBase.isEmpty');

  @override
  bool get isEmpty {
    _$isEmptyAtom.reportRead();
    return super.isEmpty;
  }

  @override
  set isEmpty(bool value) {
    _$isEmptyAtom.reportWrite(value, super.isEmpty, () {
      super.isEmpty = value;
    });
  }

  @override
  String toString() {
    return '''
calendarController: ${calendarController},
isEmpty: ${isEmpty}
    ''';
  }
}
