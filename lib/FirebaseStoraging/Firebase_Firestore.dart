import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_pad_app/utils/Contants.dart';

import '../models/Models.dart';

class Firebase_Firestore extends GetxController {
  RxList<Models> notes = <Models>[].obs;

  final fireStore = FirebaseFirestore.instance;

  addNote(Models noteData) async {
    CollectionReference collectionReference = fireStore.collection(
      CollectionID,
    );
    QuerySnapshot snapshot = await collectionReference.get();
    int docCount = snapshot.size + 1;
    String CollectionIdset = "Note_$docCount";

    fireStore.collection(CollectionID).doc(CollectionIdset).set({
      "Title": noteData.title,
      "Description": noteData.description,
      "Creadted Date": noteData.createdTime,
      "Updated Date": noteData.updatedTime,
    });
  }

  deleteElement(String docId) {
    fireStore.collection(CollectionID).doc(docId).delete();
  }

  getNoteTime() {
    String createdTime = DateFormat.MMMEd().format(notes[2].createdTime);
    return createdTime;
  }

  Future<void> updateDocument(String docId, Map<String, dynamic> updatedData) async {
    try {
      await fireStore
          .collection(CollectionID)
          .doc(docId) // Specify the document by ID
          .update(updatedData); // Update the fields you want
      print("Document updated successfully!");
    } catch (e) {
      print("Error updating document: $e");
    }
  }

  Future<DocumentSnapshot> getDocument(String documentId) async {
    try {
      // Fetch the specific document by its ID
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection(CollectionID)
          .doc(documentId)
          .get();

      // Return the document snapshot
      return docSnapshot;
    } catch (e) {
      print("Error fetching document: $e");
      rethrow;
    }
  }

  editFile({required String docId,required String title, required String description, required DateTime lastTime} ){
    FirebaseFirestore.instance.collection(CollectionID).doc(docId).update({
      "Title": title,
      "Description": description,
      "Creadted Date": lastTime,
      "Updated Date": '',
    }).then((_) {
      print("Data updated successfully!");
    }).catchError((error) {
      print("Failed to update: $error");
    });
  }

  Future<void> searchByTitlePrefix(String query) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection(CollectionID)
          .orderBy('Title')
          .startAt([query])
          .endAt([query + '\uf8ff'])
          .get();

      for (var doc in querySnapshot.docs) {
        print("Matching Note: ${doc.data()}");
      }
    } catch (e) {
      print("Error searching: $e");
    }
  }

}
