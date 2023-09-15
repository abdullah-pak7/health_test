import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:health_test/sqlite_db/exercise_controller.dart';

class AddExerciseScreen extends StatelessWidget {
  final exerciseController = Get.put(ExerciseController());

  void onAddProductScreenPress() {
    if (Get.arguments != null) {
      exerciseController.handleAddButton(Get.arguments.id);
    }
    else {
      exerciseController.handleAddButton();
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      var args = Get.arguments;
      print(args);
      exerciseController.nameController.value.text = args.name;
      exerciseController.descriptionController.value.text = args.description;
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.title_rounded),
                  hintText: "Name".tr,
                  border: OutlineInputBorder(),
                ),
                controller: exerciseController.nameController.value,
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: "Description".tr,
                  border: OutlineInputBorder(),
                ),
                controller: exerciseController.descriptionController.value,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade700),
                  child: Text(
                    "Add Product".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: onAddProductScreenPress,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}