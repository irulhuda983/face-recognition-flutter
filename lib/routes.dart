import 'package:absensi/layouts/main_layout.dart';
import 'package:absensi/pages/home_page.dart';
import 'package:absensi/pages/jurnal_page.dart';
import 'package:absensi/pages/log_page.dart';
import 'package:absensi/pages/profile_page.dart';
import 'package:absensi/pages/login_page.dart';
import 'package:absensi/pages/add_absensi_page.dart';

enum MyRoute {
  login('/login'),
  main('/'),
  home('/home'),
  jurnal('/jurnal'),
  addAbsensi('/absensi/add'),
  log('/log'),
  profile('/profile');

  final String name;
  const MyRoute(this.name);
}

final routes = {
  MyRoute.login.name: (context) => const LoginPage(),
  MyRoute.main.name: (context) => const MainLayout(),
  MyRoute.home.name: (context) => const HomePage(),
  MyRoute.jurnal.name: (context) => const JurnalPage(),
  MyRoute.addAbsensi.name: (context) => const AddAbsensiPage(),
  MyRoute.log.name: (context) => const LogPage(),
  MyRoute.profile.name: (context) => const ProfilePage(),
};
