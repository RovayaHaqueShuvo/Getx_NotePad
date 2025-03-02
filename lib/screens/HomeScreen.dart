import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getX_management/NotePadController.dart';
import '../utils/AppColor.dart';
import '../utils/CustomeDesign.dart';
import 'routes/Routes.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotePadController());

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
                  child:
                  Obx(()=>
                  controller.notes.isEmpty
                      ? Text(
                    "No Notes Found",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "serif",
                    ),
                  )
                      :  SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          primary: false,
                          itemCount: controller.notes.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Customedesign(context: context, index: index, controller: controller,);
                          },
                        ),
                      ],
                    ),
                  ),
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
