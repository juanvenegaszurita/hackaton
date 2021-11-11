// get
import 'package:get/get.dart';
// personal
import 'package:hackaton/ui/ui.dart';
import 'package:hackaton/ui/public/public.dart';
import 'package:hackaton/ui/private/private.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/login', page: () => LoginUi()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/home', page: () => HomeUI()),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
  ];
}
