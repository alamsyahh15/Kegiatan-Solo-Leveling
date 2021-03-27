import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:oyos_clone/Routes.dart';

void main({String env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  env = env ?? "dev";
  await GlobalConfiguration().loadFromPath("assets/config/$env.json");
  print(GlobalConfiguration().get("appTitle"));

  Routes();
}
