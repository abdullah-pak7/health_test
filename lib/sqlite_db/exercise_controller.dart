import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:health_test/sqlite_db/exercise_model.dart';
import 'package:health_test/sqlite_db/database_helper.dart';

class ExerciseControllers extends GetxController {
  var exercises = <Exercise>[].obs;
  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  final showSearchField = false.obs;

  @override
  void onInit() {
    exercises.value = [];
    fetchExercise();
    super.onInit();
  }

  fetchExercise() async {
    ExerciseDatabaseHelper.db
        .getExerciseList()
        .then((exerciseList) => {exercises.value = exerciseList});
  }

  void addExercise(Exercise exerciseInstance) {
    if (exerciseInstance.id != null) {
      ExerciseDatabaseHelper.db.updateExercise(exerciseInstance).then((value) {updateExercise(exerciseInstance);});
    }
    else {
      ExerciseDatabaseHelper.db.insertExercise(exerciseInstance).then((value) => addExercise(exerciseInstance));
    }
  }

  void deleteExercise(Exercise exerciseInstance) {
    ExerciseDatabaseHelper.db.deleteExercise(exerciseInstance.id!).then((_) => deleteExercise(exerciseInstance));
  }

  void updateList(Exercise exerciseInstance) async {
    var result = await fetchExercise();
    if (result != null) {
      final index = result.indexOf(exerciseInstance);
      result[index] = exerciseInstance;
    }
  }

  void updateExercise(Exercise exerciseInstance) {
    ExerciseDatabaseHelper.db.updateExercise(exerciseInstance).then((value) => updateList(exerciseInstance));
  }

  void handleAddButton([id]) {
    if (id != null) {
      var product = Exercise(id: id, name: nameController.value.text, description: descriptionController.value.text,);
      addExercise(product);
    }
    else {
      var exerciseInstance = Exercise(name: nameController.value.text, description: descriptionController.value.text,);
      addExercise(exerciseInstance);
    }
    nameController.value.text = "";
    descriptionController.value.text = "";
  }

  void toggleShowSearch(){
    showSearchField.value = !showSearchField.value;
  }

  @override
  void onClose() {
    ExerciseDatabaseHelper.db.close();
    super.onClose();
  }

}

class ExerciseController extends GetxController {
  var exercises = <Exercise>[].obs;
  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  final showSearchField = false.obs;

  @override
  void onInit() {
    exercises.value = [];
    fetchExercises();
    super.onInit();
  }

  fetchExercises() async {
    ExerciseDatabaseHelper.db
        .getExerciseList()
        .then((productList) => {exercises.value = productList});
  }

  void addExercise(Exercise exerciseInstance) {
    if (exerciseInstance.id != null) {
      print("Inside add product and id is not null ${exerciseInstance.id}");
      ExerciseDatabaseHelper.db.updateExercise(exerciseInstance).then((value) {
        updateProduct(exerciseInstance);
      });
    } else {
      ExerciseDatabaseHelper.db
          .insertExercise(exerciseInstance)
          .then((value) => exercises.add(exerciseInstance));
    }
  }

  void deleteExercise(Exercise exerciseInstance) {
    ExerciseDatabaseHelper.db
        .deleteExercise(exerciseInstance.id!)
        .then((_) => exercises.remove(exerciseInstance));
  }

  void updateList(Exercise exerciseInstance) async {
    var result = await fetchExercises();
    if (result != null) {
      final index = exercises.indexOf(exerciseInstance);
      exercises[index] = exerciseInstance;
    }
  }

  void updateProduct(Exercise exerciseInstance) {
    ExerciseDatabaseHelper.db
        .updateExercise(exerciseInstance)
        .then((value) => updateList(exerciseInstance));
  }

  void handleAddButton([id]) {
    print(id);
    if (id != null) {
      var exerciseInstance = Exercise(
        id: id,
        name: nameController.value.text,
        description: descriptionController.value.text,
      );
      addExercise(exerciseInstance);
    } else {
      var product = Exercise(
        name: nameController.value.text,
        description: descriptionController.value.text,
      );
      addExercise(product);
    }
    nameController.value.text = "";
    descriptionController.value.text = "";
  }

  void toggleShowSearch(){
    showSearchField.value = !showSearchField.value;
  }


  @override
  void onClose() {
    ExerciseDatabaseHelper.db.close();
    super.onClose();
  }
}
