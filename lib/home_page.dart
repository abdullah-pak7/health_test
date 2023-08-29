import 'package:flutter/material.dart';
import 'package:health_test/home_controller.dart';
import 'package:health_test/my_card.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Test', style: TextStyle(color: Color(0xffFFFFFF)),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff805219),
      ),
      body: ValueListenableBuilder(
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        homeController.getData();
      },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
