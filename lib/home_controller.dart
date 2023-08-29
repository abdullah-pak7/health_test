import 'package:flutter/cupertino.dart';
import 'package:health/health.dart';
import 'package:health_test/blood_glucose.dart';
import 'package:health_test/health_repository.dart';

class HomeController {
  final repository = HealthRepository();
  //Future<void> getDataFirebase() async {
  //  final moviesRef = FirebaseFirestore.instance
  //      .collection('movies')
  //      .withConverter<Movie>(
  //          fromFirestore: (snapshots, _) => Movie.fromJson(snapshots.data()!),
  //          toFirestore: (movie, _) => movie.toJson());

  //  final movies = await moviesRef.get();

  //  print(movies.docs.map((e) => e.data()).toList());
  //}

  final bloodGlucose = ValueNotifier(<BloodGlucose>[]);
  Future<void> getData() async {
    bloodGlucose.value = await repository.getBloodGlucose();
  }
}

// class Movie {
//   final String id;
//   final String name;
//
//   Movie(this.id, this.name);
//
//   factory Movie.fromJson(Map<String, dynamic> json) {
//     return Movie(
//       json['id'] as String,
//       json['name'] as String,
//     );
//   }
//
//   Map<String, dynamic> toJson() => <String, dynamic>{
//     'id': id,
//     'name': name,
//   };
// }