
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_pad_app/FirebaseStoraging/Firebase_Firestore.dart';
import 'package:note_pad_app/screens/routes/Routes.dart';

import '../models/Models.dart';
import '../utils/AppColor.dart';

class Notescreen extends StatelessWidget {
  const Notescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Firebase_Firestore());

    // Check if Get.arguments is null or not a Map<String, dynamic>
    final arg = Get.arguments ?? {};
    // Default to an empty map

    final index = arg['index'];

    if (arg['isUpdate'] == true) {
      return FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getDocument(index),
        // Call the getDocument method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            ); // Show loading indicator while waiting
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var data =
                snapshot.data!.data()
                    as Map<String, dynamic>; // Access document data

            final titleController = TextEditingController(text: data["Title"]);
            final descriptionController = TextEditingController(
              text: data['Description'].toString(),
            );
            DateTime time = DateTime.now();

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  controller.editFile(
                    docId: index,
                    title: titleController.text.toString(),
                    description: descriptionController.text.toString(),
                    lastTime: time,
                  );
                  Get.snackbar(
                    "Saved",
                    "Note Saved",
                    backgroundColor: AppColor.done,
                    borderColor: Colors.black.withValues(alpha: .2),
                    borderWidth: 2,
                  );
                  Get.offNamed(Routes.homeScreen);
                },
                splashColor: Colors.green,
                shape: const CircleBorder(),
                backgroundColor: AppColor.primary,
                child: Icon(Icons.save),
              ),
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          "NOTE",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            fontFamily: "serif",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () => Get.back(),
                                splashColor: AppColor.primary,
                                highlightColor: Colors.red.withValues(alpha: .8),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.link),
                                    highlightColor: AppColor.primary
                                        .withValues(alpha: .8),
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 2),
                                  IconButton(
                                    icon: Icon(Icons.share_outlined),
                                    highlightColor: AppColor.primary
                                        .withValues(alpha: .8),

                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 2),
                                  IconButton(
                                    icon: Icon(Icons.more_vert),
                                    highlightColor: AppColor.primary
                                        .withValues(alpha: .8),

                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withValues(alpha: .2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  splashColor: AppColor.primary,
                                  highlightColor: AppColor.primary.withValues(alpha: .8),
                                  icon: Icon(Icons.format_bold),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  splashColor: AppColor.primary,
                                  highlightColor: AppColor.primary.withValues(alpha: .8),

                                  icon: Icon(Icons.format_italic),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  splashColor: AppColor.primary,
                                  highlightColor: AppColor.primary.withValues(alpha: .8),

                                  icon: Icon(Icons.format_underline),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  splashColor: AppColor.primary,
                                  highlightColor: AppColor.primary.withValues(alpha: .8),

                                  icon: Icon(Icons.format_list_bulleted),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  splashColor: AppColor.primary,
                                  highlightColor: AppColor.primary.withValues(alpha: .8),

                                  icon: Icon(Icons.format_align_left),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  splashColor: AppColor.primary,
                                  highlightColor: AppColor.primary.withValues(alpha: .8),

                                  icon: Icon(Icons.format_align_center),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  splashColor: AppColor.primary,
                                  highlightColor: AppColor.primary.withValues(alpha: .8),

                                  icon: Icon(Icons.format_align_right),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withValues(alpha: .2),
                          ),
                          child: TextFormField(
                            controller: titleController,
                            maxLines: 1,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.title),
                              suffix: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                              ),
                              border: InputBorder.none,
                              hintText: "Title",
                              hintStyle: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                            showCursor: true,
                            cursorColor: AppColor.primary.withValues(alpha: .8),
                            cursorErrorColor: Colors.red,
                            cursorWidth: 4,
                            cursorOpacityAnimates: true,
                          ),
                        ),

                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                height:
                                    MediaQuery.of(context).size.height * .6,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withValues(alpha: .2),
                                ),
                                child: SingleChildScrollView(
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  child: TextFormField(
                                    controller: descriptionController,
                                    maxLines: 1000,
                                    decoration: InputDecoration(
                                      prefix: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                      ),
                                      suffix: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 1,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Description",
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    showCursor: true,
                                    cursorColor: AppColor.primary.withValues(alpha: .8),
                                    cursorErrorColor: Colors.red,
                                    cursorWidth: 3,
                                    cursorOpacityAnimates: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text("Document not found"));
          }
        },
      );
    }
    {
      final titleController = TextEditingController();
      final descriptionController = TextEditingController();
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (titleController.text.isEmpty &&
                descriptionController.text.isEmpty) {
              Get.snackbar(
                "Not Saved",
                "Please write something first to save",
                backgroundColor: AppColor.secondary,
                borderColor: Colors.black.withValues(alpha: .2),
                borderWidth: 2,
              );
            } else {
              DateTime time = DateTime.now(); // Ensure time is defined

              if (titleController.text.isEmpty &&
                  descriptionController.text.isNotEmpty) {
                controller.addNote(
                  Models(
                    title: "No Title",
                    description: descriptionController.text,
                    createdTime: time, // Use DateTime directly
                    updatedTime: null,
                  ),
                );
                Get.snackbar(
                  "Saved",
                  "Title Saved",
                  backgroundColor: AppColor.done,
                  borderColor: Colors.black.withValues(alpha: .2),
                  borderWidth: 2,
                );
              } else if (titleController.text.isNotEmpty &&
                  descriptionController.text.isEmpty) {
                controller.addNote(
                  Models(
                    title: titleController.text,
                    description: "No Description",
                    createdTime: time, // Use DateTime directly
                    updatedTime: null,
                  ),
                );
                Get.snackbar(
                  "Saved",
                  titleController.text,
                  backgroundColor: AppColor.done,
                  borderColor: Colors.black.withValues(alpha: .2),
                  borderWidth: 2,
                );
              } else {
                controller.addNote(
                  Models(
                    title: titleController.text,
                    description: descriptionController.text,
                    createdTime: time, // Use DateTime directly
                    updatedTime: null,
                  ),
                );
                Get.snackbar(
                  "Saved",
                  "Note Saved",
                  backgroundColor: AppColor.done,
                  borderColor: Colors.black.withValues(alpha: .2),
                  borderWidth: 2,
                );
                Get.offNamed(Routes.homeScreen);
              }
            }
          },
          splashColor: Colors.green,
          shape: const CircleBorder(),
          backgroundColor: AppColor.primary,
          child: Icon(Icons.save),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "NOTE",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      fontFamily: "serif",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Get.back(),
                          splashColor: AppColor.primary,
                          highlightColor: Colors.red.withValues(alpha: .6),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.link),
                              highlightColor: AppColor.primary.withValues(alpha: .8),
                              onPressed: () {},
                            ),
                            SizedBox(width: 2),
                            IconButton(
                              icon: Icon(Icons.share_outlined),
                              highlightColor: AppColor.primary.withValues(alpha: .8),

                              onPressed: () {},
                            ),
                            SizedBox(width: 2),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              highlightColor: AppColor.primary.withValues(alpha: .8),

                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withValues(alpha: .8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {},
                            splashColor: AppColor.primary,
                            highlightColor: AppColor.primary.withValues(alpha: .8),
                            icon: Icon(Icons.format_bold),
                          ),
                          IconButton(
                            onPressed: () {},
                            splashColor: AppColor.primary,
                            highlightColor: AppColor.primary.withValues(alpha: .8),

                            icon: Icon(Icons.format_italic),
                          ),
                          IconButton(
                            onPressed: () {},
                            splashColor: AppColor.primary,
                            highlightColor: AppColor.primary.withValues(alpha: .8),

                            icon: Icon(Icons.format_underline),
                          ),
                          IconButton(
                            onPressed: () {},
                            splashColor: AppColor.primary,
                            highlightColor: AppColor.primary.withValues(alpha: .8),

                            icon: Icon(Icons.format_list_bulleted),
                          ),
                          IconButton(
                            onPressed: () {},
                            splashColor: AppColor.primary,
                            highlightColor: AppColor.primary.withValues(alpha: .8),

                            icon: Icon(Icons.format_align_left),
                          ),
                          IconButton(
                            onPressed: () {},
                            splashColor: AppColor.primary,
                            highlightColor: AppColor.primary.withValues(alpha: .8),

                            icon: Icon(Icons.format_align_center),
                          ),
                          IconButton(
                            onPressed: () {},
                            splashColor: AppColor.primary,
                            highlightColor: AppColor.primary.withValues(alpha: .8),

                            icon: Icon(Icons.format_align_right),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withValues(alpha: 0.2),
                    ),
                    child: TextFormField(
                      controller: titleController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.title),
                        suffix: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                      showCursor: true,
                      cursorColor: AppColor.primary.withValues(alpha: .8),
                      cursorErrorColor: Colors.red,
                      cursorWidth: 4,
                      cursorOpacityAnimates: true,
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * .6,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withValues(alpha: .2),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 100,
                                maxHeight: MediaQuery.of(context).size.height * .6,
                              ),
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                                  child: TextFormField(
                                    controller: descriptionController,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      prefix: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                      ),
                                      suffix: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 1),
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Description",
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    showCursor: true,
                                    cursorColor: AppColor.primary.withValues(alpha: .8),
                                    cursorErrorColor: Colors.red,
                                    cursorWidth: 3,
                                    cursorOpacityAnimates: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
