// get
import 'package:get/get.dart';
// personal
import 'package:hackaton/ui/ui.dart';
import 'package:hackaton/ui/public/public.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/login', page: () => LoginUi()),
  ];
}
