import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:note_pad_app/FirebaseStoraging/Firebase_Firestore.dart';
import 'package:note_pad_app/utils/Contants.dart';

import '../getX_management/NotePadController.dart';
import '../utils/AppColor.dart';
import '../utils/CustomeDesign.dart';
import 'routes/Routes.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Firebase_Firestore());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.red,
        shape: const CircleBorder(),
        backgroundColor: AppColor.primary,
        onPressed: () => Get.toNamed(Routes.noteScreen),
        child: Icon(Icons.add, size: 35),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "MY NOTE",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    fontFamily: "serif",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu_rounded),
                    Row(
                      children: [
                        Icon(Icons.manage_search_rounded),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamBuilder(
                          stream:
                              controller.fireStore
                                  .collection(CollectionID)
                                  .snapshots(),
                          builder: (context, snapshot) {

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Show loading indicator while waiting
                              EasyLoading.show(status: "Waiting...");
                              return Center(child: const Text("Data Loading"));
                            } else if (snapshot.hasError) {
                              // Dismiss loading and show error if something goes wrong
                              EasyLoading.dismiss();
                              EasyLoading.showError("${snapshot.error}");
                              return Center(
                                child: const Text("An error occurred"),
                              );
                            } else {

                              // Once data is loaded, display ListView
                              EasyLoading.dismiss();
                              return ListView.builder(
                                shrinkWrap: true,
                                reverse: false,
                                primary: false,
                                itemCount:snapshot.data!.docs.length,  // Check if data exists

                                itemBuilder: (context, index) {
                                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                    return Center(child: Text("No data available"));  // Show a message if no data is found
                                  }

                                  final data = snapshot.data!.docs[index];
                                  return Customedesign(
                                    controller: controller,
                                    data: data,
                                    context: context,
                                    index: index,

                                  );
                                },
                              );

                            }
                          },
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
