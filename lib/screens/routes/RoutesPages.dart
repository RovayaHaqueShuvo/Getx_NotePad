import 'package:get/get.dart';
import 'package:note_pad_app/screens/note_screen.dart';
import '../home_screen.dart';
import 'Routes.dart';

class RoutesPages {
  static List<GetPage<dynamic>>? routes = [
    GetPage(name: Routes.homeScreen, page: () => Homescreen()),
    GetPage(name: Routes.noteScreen, page: () => Notescreen()),
  ];
}
