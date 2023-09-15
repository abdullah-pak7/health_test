import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:health_test/step_counter_pkg/database_helper.dart';
import 'package:health_test/step_counter_pkg/steps_model.dart';

class StepsController extends GetxController {
  var stepsList = <Steps>[].obs;
  var nameController = TextEditingController();
  final showSearchField = false.obs;

  @override
  void onInit() {
    stepsList.value = [];
    fetchExercises();
    super.onInit();
  }

  fetchExercises() async {
    StepsDatabaseHelper.db
        .getExerciseList()
        .then((productList) => {stepsList.value = productList});
  }

  void addSteps(Steps exerciseInstance) {
    if (exerciseInstance.id != null) {
      print("Inside add product and id is not null ${exerciseInstance.id}");
      StepsDatabaseHelper.db.updateSteps(exerciseInstance).then((value) {
        updateSteps(exerciseInstance);
      });
    } else {
      StepsDatabaseHelper.db
          .insertSteps(exerciseInstance)
          .then((value) => stepsList.add(exerciseInstance));
    }
  }

  void deleteSteps(Steps exerciseInstance) {
    StepsDatabaseHelper.db
        .deleteSteps(exerciseInstance.id!)
        .then((_) => stepsList.remove(exerciseInstance));
  }

  void updateList(Steps exerciseInstance) async {
    var result = await fetchExercises();
    if (result != null) {
      final index = stepsList.indexOf(exerciseInstance);
      stepsList[index] = exerciseInstance;
    }
  }

  void updateSteps(Steps exerciseInstance) {
    StepsDatabaseHelper.db
        .updateSteps(exerciseInstance)
        .then((value) => updateList(exerciseInstance));
  }

  void handleAddButton([id]) {
    print(id);
    if (id != null) {
      var exerciseInstance = Steps(
        id: id,
        steps: nameController.value.text,
      );
      addSteps(exerciseInstance);
    } else {
      var product = Steps(
        steps: nameController.value.text,
      );
      addSteps(product);
    }
    // nameController.value.text = "0";
  }

  void toggleShowSearch(){
    showSearchField.value = !showSearchField.value;
  }


  @override
  void onClose() {
    StepsDatabaseHelper.db.close();
    super.onClose();
  }
}
