import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:user_manager/service/user_service.dart';
import 'package:user_manager/view/home_page.dart';
import 'package:yaru/yaru.dart' as yaru;

Future<void> main() async {
  final userService = UserService(uri: 'localhost:3000');
  Injector.appInstance.registerDependency<UserService>(() => userService);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: yaru.lightTheme,
      darkTheme: yaru.darkTheme,
      home: HomePage(),
    );
  }
}
