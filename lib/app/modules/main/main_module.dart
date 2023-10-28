import 'package:delivery_screens/app/modules/main/main_Page.dart';
import 'package:delivery_screens/app/modules/main/main_store.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MainStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MainPage()),
  ];

  @override
  Widget get view => MainPage();
}
