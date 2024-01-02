import 'package:curtains_app/screens/add/pages/first_step_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(steps: stepList(),
      type: StepperType.horizontal,),
    );
  }
  List<Step> stepList() => [
  const Step(title: Text('First Step'), content:FirstStepScreen()),
  const Step(title: Text('Two Step'), content: Center(child: Text('Address'),)),
  const Step(title: Text('Confirm'), content: Center(child: Text('Confirm'),))];


}
