import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jawa_app/app/utils/theme_data.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';
import 'package:jawa_app/app/utils/utils.dart';

import 'app/bindings/global_binding.dart';

import 'app/routes/app_pages.dart';

final navkey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Connection connectionStatus = Connection.getInstance();
  connectionStatus.initialize();

  final toastService = UIToastService();
  toastService.navkey = navkey;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = CustomThemeData(context);
    return GetMaterialApp(
        navigatorKey: navkey,
        title: "Application",
        initialBinding: GlobalBinding(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: theme.theme);
  }
}
