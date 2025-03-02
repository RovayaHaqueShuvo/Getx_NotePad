import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_pad_app/screens/routes/Routes.dart';

import '../getX_management/NotePadController.dart';
import '../models/Models.dart';
import '../utils/AppColor.dart';

class Notescreen extends StatelessWidget {
  const Notescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotePadController());

    final arg =
        Get.arguments != null
            ? Get.arguments as Map
            : {"controller": null, "index": null, "isUpdate": false};

    final titleController = TextEditingController(
      text: arg['isUpdate'] ? controller.notes[arg['index']].title : null,
    );
    final descriptionController = TextEditingController(
      text: arg['isUpdate'] ? controller.notes[arg['index']].description : null,
    );

    print(arg['isUpdate']);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.isEmpty &&
              descriptionController.text.isEmpty) {
            Get.snackbar(
              "Not Saved",
              "Please write something first to save",
              backgroundColor: AppColor.secondary,
              borderColor: Colors.black.withOpacity(.2),
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
                borderColor: Colors.black.withOpacity(.2),
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
                "Title Saved",
                backgroundColor: AppColor.done,
                borderColor: Colors.black.withOpacity(.2),
                borderWidth: 2,
              );
            } else {
              arg['isUpdate']
                  ? controller.updateNote(index: arg["index"],newTitle: titleController.text , newDescription: descriptionController.text )
                  : controller.addNote(
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
                borderColor: Colors.black.withOpacity(.2),
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
                        highlightColor: Colors.red.withOpacity(.6),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.link),
                            highlightColor: AppColor.primary.withOpacity(.8),
                            onPressed: () {},
                          ),
                          SizedBox(width: 2),
                          IconButton(
                            icon: Icon(Icons.share_outlined),
                            highlightColor: AppColor.primary.withOpacity(.8),

                            onPressed: () {},
                          ),
                          SizedBox(width: 2),
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            highlightColor: AppColor.primary.withOpacity(.8),

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
                      color: Colors.grey.withOpacity(.2),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          splashColor: AppColor.primary,
                          highlightColor: AppColor.primary.withOpacity(.8),
                          icon: Icon(Icons.format_bold),
                        ),
                        IconButton(
                          onPressed: () {},
                          splashColor: AppColor.primary,
                          highlightColor: AppColor.primary.withOpacity(.8),

                          icon: Icon(Icons.format_italic),
                        ),
                        IconButton(
                          onPressed: () {},
                          splashColor: AppColor.primary,
                          highlightColor: AppColor.primary.withOpacity(.8),

                          icon: Icon(Icons.format_underline),
                        ),
                        IconButton(
                          onPressed: () {},
                          splashColor: AppColor.primary,
                          highlightColor: AppColor.primary.withOpacity(.8),

                          icon: Icon(Icons.format_list_bulleted),
                        ),
                        IconButton(
                          onPressed: () {},
                          splashColor: AppColor.primary,
                          highlightColor: AppColor.primary.withOpacity(.8),

                          icon: Icon(Icons.format_align_left),
                        ),
                        IconButton(
                          onPressed: () {},
                          splashColor: AppColor.primary,
                          highlightColor: AppColor.primary.withOpacity(.8),

                          icon: Icon(Icons.format_align_center),
                        ),
                        IconButton(
                          onPressed: () {},
                          splashColor: AppColor.primary,
                          highlightColor: AppColor.primary.withOpacity(.8),

                          icon: Icon(Icons.format_align_right),
                        ),
                        IconButton(
                          onPressed: () {},
                          splashColor: AppColor.primary,
                          highlightColor: AppColor.primary.withOpacity(.8),

                          icon: Icon(Icons.format_align_justify),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(.2),
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
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                    showCursor: true,
                    cursorColor: AppColor.primary.withOpacity(.8),
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
                        height: MediaQuery.of(context).size.height * .65,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(.2),
                        ),
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: TextFormField(
                            controller: descriptionController,
                            maxLines: 1000,
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
                            cursorColor: AppColor.primary.withOpacity(.8),
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
  }
}
