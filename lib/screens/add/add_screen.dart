import 'package:curtains_app/screens/add/pages/second_step_screen.dart';
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
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const Text(
                'Add Curtains',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stepper(
            elevation: 0,
            connectorThickness: 2,
            steps: stepList(),
            type: StepperType.horizontal,
          ),
        ),
      ])),
    );
  }

  List<Step> stepList() => [
        const Step(
          isActive: true,
          title: Text(''),
          content: SecondStep(),
        ),
        const Step(
          title: Text(''),
          content: SecondStep(),
        ),
        const Step(
            title: Text(''),
            content: Center(
              child: Text('Confirm'),
            ))
      ];
}



// Stepper(
//             elevation: 0,
//             connectorThickness: 2,
//             steps: stepList(),
//             type: StepperType.horizontal,
//           ),