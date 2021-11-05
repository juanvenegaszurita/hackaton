// get
import 'package:get/get.dart';
// personal
import 'package:hackaton/ui/ui.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
  ];
}
