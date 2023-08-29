import 'package:health/health.dart';
import 'package:health_test/blood_glucose.dart';

class HealthRepository {
  final health = HealthFactory();

  Future<List<BloodGlucose>> getBloodGlucose() async {
      bool requested = await health.requestAuthorization([HealthDataType.BLOOD_GLUCOSE]);
      if (requested) {
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
            DateTime.now().subtract(const Duration(days: 7)),
            DateTime.now(),
            [HealthDataType.BLOOD_GLUCOSE]
        );

        return healthData.map((e) {
          var b = e;
          return BloodGlucose(
            double.parse(b.value.toJson()['numericValue']),
            b.unitString,
            b.dateFrom,
            b.dateTo,
          );
        }).toList();
      }
      return [];
  }
}