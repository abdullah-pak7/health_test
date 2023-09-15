import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:health_test/sqlite_db/exercise_controller.dart';
import 'package:health_test/sqlite_db/add_exercise_screen.dart';

class ExerciseListScreen extends StatelessWidget {
  final exerciseController = Get.put(ExerciseController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          // title property shows search field or app title
          title: Obx(
            () => !exerciseController.showSearchField.value ? Text("title".tr) :
            TextField(
              onChanged: (text) {
                  if (text.length == 1) {
                    Get.snackbar("Error!", "Sorry this feature not available yet",
                      icon: Icon(Icons.error, color: Colors.red),
                    );
                  }
                },
              cursorColor: Colors.white,
              decoration: InputDecoration(
                fillColor: Colors.white,
                icon: Icon(Icons.search_rounded),
                labelText: "Search".tr,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.add), onPressed: () => Get.to(AddExerciseScreen()),)
          ],
        ),
        backgroundColor: Colors.grey.shade50,
        body: Column(
          children: [
            ExerciseList(),
          ],
        ),
        // Container(
        //   child: ListView.builder(
        //     itemCount: exerciseController.exercises.length,
        //     itemBuilder: (context, index) {
        //       return Dismissible(
        //         background: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.red,
        //         borderRadius: BorderRadius.circular(5),
        //       ),
        //       alignment: Alignment.centerRight,
        //       child: Icon(
        //         Icons.delete,
        //         size: 50,
        //       ),
        //     ),
        //         direction: DismissDirection.endToStart,
        //         onDismissed: (direction) {
        //       exerciseController.deleteExercise(exerciseController.exercises[index]);
        //
        //       Get.snackbar(
        //         "${exerciseController.exercises[index].name} Deleted!",
        //         "",
        //         icon: Icon(Icons.message),
        //         onTap: (_) {},
        //         barBlur: 20,
        //         isDismissible: true,
        //         duration: Duration(seconds: 2),
        //       );
        //     },
        //         key: UniqueKey(),
        //         child: GestureDetector(
        //       onDoubleTap: () {
        //         // Open existing Product item  in Add New Product Screen.
        //         Get.to(
        //           AddExerciseScreen(),
        //           arguments: exerciseController.exercises[index],
        //         );
        //       },
        //       child: Card(
        //         margin: const EdgeInsets.all(12),
        //         child: Padding(
        //           padding: EdgeInsets.all(16),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.end,
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     "${exerciseController.exercises[index].name}",
        //                     style: TextStyle(
        //                       fontSize: 20,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     "${exerciseController.exercises[index].description}",
        //                     style: TextStyle(
        //                       fontSize: 16,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //       );
        //     },
        //   ),
        // ),
      ),
    );
  }
}

class ExerciseList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetX<ExerciseController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.exercises.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    size: 50,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  controller.deleteExercise(controller.exercises[index]);

                  Get.snackbar(
                    "${controller.exercises[index].name} Deleted!",
                    "",
                    icon: Icon(Icons.message),
                    onTap: (_) {},
                    barBlur: 20,
                    isDismissible: true,
                    duration: Duration(seconds: 2),
                  );
                },
                key: UniqueKey(),
                child: GestureDetector(
                  onDoubleTap: () {
                    // Open existing Product item  in Add New Product Screen.
                    Get.to(
                      AddExerciseScreen(),
                      arguments: controller.exercises[index],
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.exercises[index].name}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.exercises[index].description}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
