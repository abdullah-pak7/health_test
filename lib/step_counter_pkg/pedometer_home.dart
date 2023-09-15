import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_test/step_counter_pkg/steps_controller.dart';
import 'package:pedometer/pedometer.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class PedometerHome extends StatefulWidget {
  @override
  _PedometerHomeState createState() => _PedometerHomeState();
}

class _PedometerHomeState extends State<PedometerHome> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  final stepsController = Get.put(StepsController());
  int i = 0;
  int k = 0 ;
  String _status = '?', _steps = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    setState(() {
      if(i==0){
        k = event.steps;
        i-- ;
      }
      int j = event.steps ;
      _steps = (j - k).toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
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
    _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pedometer Example'),
          elevation: 0,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: (){
                stepsController.nameController..text = _steps;
                stepsController.handleAddButton();
                i = 0 ;
                },
                icon: Icon(Icons.add),
              ),
              Text('Steps Taken', style: TextStyle(fontSize: 20),),
              Text(_steps, style: TextStyle(fontSize: 30),),
              Divider(height: 30, thickness: 0, color: Colors.white,),
              Text('Pedestrian Status', style: TextStyle(fontSize: 30),),
              Icon(
                _status == 'walking' ? Icons.directions_walk : _status == 'stopped' ?
                Icons.accessibility_new : Icons.error, size: 40,
              ),
              Center(
                child: Text(
                  _status, style: _status == 'walking' || _status == 'stopped' ?
                TextStyle(fontSize: 30) : TextStyle(fontSize: 20, color: Colors.red),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                height: 250,
                child: ListView.builder(
                  itemCount: stepsController.stepsList.length,
                  itemBuilder: (context, index){
                    return Column(
                      children: [
                        SizedBox(height: 10,),
                        Text('It entry number ${index.toString()}'),
                        Text('value ${stepsController.stepsList[index].steps.toString()}'),
                        SizedBox(height: 10,),
                        Divider(height: 5, color: Colors.grey,),
                      ],
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}