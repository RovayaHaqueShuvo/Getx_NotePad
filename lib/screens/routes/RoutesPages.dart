import 'package:get/get.dart';
import 'package:note_pad_app/screens/NoteScreen.dart';
import '../HomeScreen.dart';
import 'Routes.dart';

class RoutesPages {
  static List<GetPage<dynamic>>? routes = [
    GetPage(name: Routes.homeScreen, page: () => Homescreen()),
    GetPage(name: Routes.noteScreen, page: () => Notescreen()),
  ];
}
