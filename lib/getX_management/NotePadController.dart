// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../models/Models.dart';
//
// class NotePadController extends GetxController {
//   RxList<Models> notes = <Models>[].obs;
//
//   addNote(Models noteData) {
//     notes.add(noteData);
//     update();
//   }
//
//   deleteElement(int index) {
//     notes.removeAt(index);
//     update();
//   }
//
//   getNoteTime() {
//     String createdTime = DateFormat.MMMEd().format(notes[2].createdTime);
//     return createdTime;
//   }
//
//   void updateNote({required int index,required String newTitle,required String newDescription}) {
//     if (index >= 0 && index < notes.length) {
//       notes[index].title = newTitle;
//       notes[index].description = newDescription;
//       notes[index].updatedTime = DateTime.now();
//     }
//       notes.refresh(); // Ensures UI updates
//     }
//   }
