import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolistbloc/app/module/home/home_page_module.dart';
import 'package:todolistbloc/app/module/initial_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    [
      r.child(
        '/',
        child: (context) => const InitialPage(),
      ),
      r.module(
        '/home',
        module: HomePageModule(),
      ),
    ];
  }
}
