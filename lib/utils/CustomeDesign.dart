import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_pad_app/FirebaseStoraging/Firebase_Firestore.dart';
import 'package:note_pad_app/screens/NoteScreen.dart';
import 'package:note_pad_app/screens/routes/Routes.dart';

class Customedesign extends StatelessWidget {
  final BuildContext context;
  final index;
  final data;
  final controller;

  const Customedesign({
    super.key,
    required this.context,
    required this.index,
    required this.data, this.controller
  });

  @override
  Widget build(BuildContext context) {
    final dateTime = (data["Creadted Date"] as Timestamp).toDate();
    final time = DateFormat.MMMEd().format(dateTime);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        horizontalTitleGap: 0,
        onTap: () {


          Get.toNamed(
            Routes.noteScreen,
            arguments: {
              "index": data.id,
              "isUpdate": true,
            },
          );
        },
        onLongPress: () {
          Get.defaultDialog(
            title: "Delete",
            content: Text(
              "Are you sure to delete this note?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            titleStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            textCancel: "Close",
            textConfirm: "Ok",
            onCancel: () => Navigator.pop(context),
            onConfirm: () {
              controller.deleteElement(data.id);
              Navigator.pop(context);
            },
          );
        },
        // Background color
        leading: Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        ),
        title: Text(
          data['Title'],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data["Description"],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(.6),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
            SizedBox(height: 10),
            Text(
              "$time",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(.6),
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
