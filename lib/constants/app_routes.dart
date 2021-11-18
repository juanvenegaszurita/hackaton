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
    GetPage(name: '/resetPassword', page: () => ResetPasswordUI()),
    GetPage(name: '/updateProfile', page: () => UpdateProfileUI()),
    GetPage(name: '/tournamentDashboard', page: () => TournamentDashboardUI()),
  ];
}
