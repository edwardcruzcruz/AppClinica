import 'package:flutter_app/Utils/Shared_Preferences.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();
Future setupLocator() async {
  locator.registerSingleton<Var_shared>(await Var_shared.getInstance());
}
