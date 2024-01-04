import 'package:curtains_app/screens/add/pages/second_step_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/ui/app_style.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  int currentStep = 0;
  final meterPriceController = TextEditingController();
  final heightTextController = TextEditingController();
  final widthTextController = TextEditingController();
  var calculatedPrice = '0\$';

  @override
  void initState() {
    super.initState();
    meterPriceController.addListener(_onMeterPriceChanged);
  }

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
            controlsBuilder: (context, details) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: Color(0xFF2E56FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      setState(() {
                        currentStep < 2
                            ? currentStep += 1
                            : null; // Change the step
                      });
                    },
                    child: Container(
                      width: 360,
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Next',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.33,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            connectorThickness: 2,
            steps: stepList(),
            type: StepperType.horizontal,
          ),
        ),
      ])),
    );
  }

  List<Step> stepList() => [
        Step(
          isActive: true,
          title: Text(''),
          content: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 75, 75, 75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color.fromARGB(255, 75, 75, 75),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            String currentValue = heightTextController.text;
                            double currentValueAsDouble =
                                double.tryParse(currentValue) ?? 0.0;
                            double newValue = currentValueAsDouble -1.0;
                            heightTextController.text = newValue<0?"": newValue.toStringAsFixed(2); // Masofani belgilash uchun
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: const Center(
                              child: Text(
                                '-1',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        // Raqam kiritish mumkin bo'lishi uchun
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}')),
                          // Faqat demical raqamlarni kirita olish
                        ],
                        controller: heightTextController,
                        decoration: InputDecoration(
                          labelText: "Parda bo`yi m²",
                          contentPadding: const EdgeInsets.all(20),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            String currentValue = heightTextController.text;
                            double currentValueAsDouble =
                                double.tryParse(currentValue) ?? 0.0;
                            double newValue = currentValueAsDouble + 1.0;
                            heightTextController.text = newValue
                                .toStringAsFixed(2); // Masofani belgilash uchun
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: const Center(
                              child: Text(
                                '+1',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            String currentValue = widthTextController.text;
                            double currentValueAsDouble =
                                double.tryParse(currentValue) ?? 0.0;
                            double newValue = currentValueAsDouble -1.0;
                            widthTextController.text = newValue<0?"": newValue.toStringAsFixed(2); // Masofani belgilash uchun
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: const Center(
                              child: Text(
                                '-1',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    Expanded(
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        // Raqam kiritish mumkin bo'lishi uchun
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}')),
                          // Faqat demical raqamlarni kirita olish
                        ],
                        controller: widthTextController,
                        decoration: InputDecoration(
                          labelText: "Parda eni m²",
                          contentPadding: const EdgeInsets.all(20),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            String currentValue = widthTextController.text;
                            double currentValueAsDouble =
                                double.tryParse(currentValue) ?? 0.0;
                            double newValue = currentValueAsDouble + 1.0;
                            widthTextController.text = newValue
                                .toStringAsFixed(2); // Masofani belgilash uchun
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: const Center(
                              child: Text(
                                '+1',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            String currentValue = meterPriceController.text;
                            double currentValueAsDouble =
                                double.tryParse(currentValue) ?? 0.0;
                            double newValue = currentValueAsDouble -1.0;
                            meterPriceController.text = newValue<0?"": newValue.toStringAsFixed(2); // Masofani belgilash uchun
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: const Center(
                              child: Text(
                                '-1',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),


                    Expanded(
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        // Raqam kiritish mumkin bo'lishi uchun
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}')),
                          // Faqat demical raqamlarni kirita olish
                        ],
                        controller: meterPriceController,
                        decoration: InputDecoration(
                          labelText: "Parda narxi m²",
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.all(20),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            String currentValue = meterPriceController.text;
                            double currentValueAsDouble =
                                double.tryParse(currentValue) ?? 0.0;
                            double newValue = currentValueAsDouble + 1.0;
                            meterPriceController.text = newValue
                                .toStringAsFixed(2); // Masofani belgilash uchun
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            child: const Center(
                              child: Text(
                                '+1',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppStyle.divider,
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      'Hisoblangan Narx',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 75, 75, 75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                     InkWell(
                      onTap: (){
                        _showBottomSheet(context); // Show bottom sheet on button press

                      },
                      child: const Text("so`mda ko`rish",style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                      )),
                    ),
                    SizedBox(width: 15,),
                    Text(calculatedPrice.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      'Sotiladigan narx',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 75, 75, 75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: '120\$',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 75, 75, 75),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppStyle.divider,
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      'Qolgan foyda',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 75, 75, 75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text('10\$',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const Step(
          title: Text(''),
          content: SecondStep(),
        ),
        const Step(
          title: Text(''),
          content: Column(),
        )
      ];
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Convert USD to So\'m',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter USD Amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to convert USD to Som
                },
                child: Text('Convert'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onMeterPriceChanged() {
    // Access the updated text using meterPriceController.text
    double price = double.parse(meterPriceController.text);
    double height = double.parse(heightTextController.text);
    double width = double.parse(widthTextController.text);
    double calculate = price * height * width;
    calculatedPrice = "${calculate.toString()}\$";
    print(calculatedPrice);
    setState(() {});

    // For example, update the calculated price based on the new value
  }

// Widget build method and other parts of your class...
}

// Stepper(
//             elevation: 0,
//             connectorThickness: 2,
//             steps: stepList(),
//             type: StepperType.horizontal,
//           ),
