import 'dart:async';
import 'package:health_test/health_pkg_ext/home_controller.dart';
import 'package:health_test/health_pkg_ext/my_card.dart';
import 'package:pedometer/pedometer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Test', style: TextStyle(color: Color(0xffFFFFFF)),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff805219),
      ),
      body: Column(
        children: [
          Container(
            height: 350,
            child: ValueListenableBuilder(
              valueListenable: homeController.bloodGlucose,
              builder: (context, value, child) {
                return GridView(
                    padding: const EdgeInsets.all(15),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15),
                    children: [
                      for (final bloodGlucose in value)
                        MyCard(bloodGlucose: bloodGlucose),
                    ]
                );
              },
            ),
          ),
          Text('Steps Taken', style: TextStyle(fontSize: 20),),
          Text(_steps, style: TextStyle(fontSize: 30),),
          Divider(height: 20, thickness: 0, color: Colors.white,),
          Text('Pedestrian Status', style: TextStyle(fontSize: 20),),
          Icon(
            _status == 'walking'
            ? Icons.directions_walk
            : _status == 'stopped'
            ? Icons.accessibility_new
            : Icons.error,
            size: 30,
          ),
          Center(
            child: Text(_status, style: _status == 'walking' || _status == 'stopped'
              ? TextStyle(fontSize: 30)
              : TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        homeController.getData();
      },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
