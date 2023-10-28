import 'package:delivery_screens/app/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'root_page.dart';
import 'root_store.dart';

class RootModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RootStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, args) => RootPage()),
    ModuleRoute("/home", module: HomeModule()),
  ];
}
