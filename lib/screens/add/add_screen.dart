import 'dart:async';

import 'package:curtains_app/blocs/add_bloc/add_bloc.dart';
import 'package:curtains_app/blocs/add_bloc/add_event.dart';
import 'package:curtains_app/blocs/add_bloc/add_state.dart';
import 'package:curtains_app/navigator/navigator.dart';
import 'package:curtains_app/utils/ui/helper.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/model/currency.dart';
import '../../core/model/product.dart';
import '../../utils/ui/app_style.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});


  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late AddBloc addBloc;
  var statusList=<String>[];
  var collectionList=<String>[];
  int currentStep = 0;
  int backClickCounter = 0;
  Timer? _clickTimer;
  bool loading=true;
  var product =Product;
  int selectedGroup = 1; // Initially selecting the first group
  int selectedGroupForStatus= 1; // Initially selecting the first group
  List<Currency>? currencies;
  String calculatedUzsPrice = "";
  final meterPriceController = TextEditingController();
  final heightTextController = TextEditingController();
  final widthTextController = TextEditingController();
  final sellPriceTextController = TextEditingController();
  final curtainDateTextController = TextEditingController();
  final convertTextController = TextEditingController();
  final finishDateTextController = TextEditingController();
  var calculatedPrice = '0\$';
  var benefit = '0\$';

  String curtainWidth="0";

  String curtainRealPrice="0";

  String curtainSellPrice="0";

  String curtainPriceForSelling ="0";

  String curtainHeight="0";
  String collectionType="0";

  @override
  void initState() {
    super.initState();
    fetchData();

    statusList.add("Tugallangan");
    statusList.add("Yangi");
    statusList.add("Kutulmoqda");
    collectionList.add("Kolleksya 1");
    collectionList.add("Kolleksya 2");
    collectionList.add("Kolleksya 3");
    collectionList.add("Kolleksya 4");
    curtainDateTextController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    collectionList.add("Kolleksya 5");
    collectionList.add("Vertical Jaluzi ");
    collectionList.add("Turkya Kambo");
    meterPriceController.addListener(_onMeterPriceChanged);
    addBloc = BlocProvider.of<AddBloc>(context);
    sellPriceTextController.addListener(_calculateBenefit);


    addBloc.add(InitEvenet());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AddBloc, AddState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentStep > 0
                            ? currentStep--
                            : {_onDoubleTap(context)};
                      });
                    },
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
            Builder(
              builder: (context) {
                if(state is AddIntial){
                  return Expanded(
                    child: Stepper(
                      elevation: 0,
                      controlsBuilder: (context, details) {
                        return Container();
                      },
                      connectorThickness: 2,
                      steps: stepList(),
                      currentStep: currentStep,
                      type: StepperType.horizontal,
                      onStepTapped: (step) {
                        setState(() {
                          currentStep = step;
                        });
                      },
                      onStepContinue: () {
                        setState(() {
                          currentStep < 2 ? currentStep += 1 : null;
                        });
                      },
                      onStepCancel: () {
                        setState(() {
                          currentStep > 0 ? currentStep -= 1 : null;
                        });
                      },
                    ),
                  );

                }
               else  if (state is Loading){
                  return Center(child: CircularProgressIndicator(),);
                }
                else if (state is AddSuccessState){

                  return Container(child: Center(child: Text("Maxsulot Qo`shildi",style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                  ),),));
                }
                else   if(state is ErrorLoad){
                  return Center(child:Text(state.error,style: TextStyle(fontSize: 20,color: Colors.black),),);
                }
                else{
                  return Center(child: Text("nothing"),);
                }
              }
            ),
          ]));
        },
      ),
    );
  }

  List<Step> stepList() => [
        Step(
          isActive: currentStep >= 0,
          state: currentStep == 0 ? StepState.indexed : StepState.complete,
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
                            double newValue = currentValueAsDouble - 1.0;
                            heightTextController.text = newValue < 0
                                ? ""
                                : newValue.toStringAsFixed(
                                    2); // Masofani belgilash uchun
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
                            double newValue = currentValueAsDouble - 1.0;
                            widthTextController.text = newValue < 0
                                ? ""
                                : newValue.toStringAsFixed(
                                    2); // Masofani belgilash uchun
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
                            double newValue = currentValueAsDouble - 1.0;
                            meterPriceController.text = newValue < 0
                                ? ""
                                : newValue.toStringAsFixed(
                                    2); // Masofani belgilash uchun
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
                            meterPriceController.text = newValue.toStringAsFixed(2); // Masofani belgilash uchun
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
                      onTap: () {
                        calculatedUzsPrice="";
                        convertTextController.text=calculatedPrice;
                        if(currencies==null){
                          fetchData();
                        }
                        _showBottomSheet(
                            context); // Show bottom sheet on button press
                      },
                      child: const Text("so`mda ko`rish",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                          )),
                    ),
                    SizedBox(
                      width: 15,
                    ),
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
                    const SizedBox(width: 30),

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
                            String currentValue = sellPriceTextController.text;
                            double currentValueAsDouble =
                                double.tryParse(currentValue) ?? 0.0;
                            double newValue = currentValueAsDouble - 1.0;
                            sellPriceTextController.text = newValue < 0
                                ? ""
                                : newValue.toStringAsFixed(
                                2); // Masofani belgilash uchun
                          },
                          child: Container(
                            width: 40,
                            height: 40,
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
                        controller: sellPriceTextController,
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
                            String currentValue = sellPriceTextController.text;
                            double currentValueAsDouble =
                                double.tryParse(currentValue) ?? 0.0;
                            double newValue = currentValueAsDouble + 1.0;
                            sellPriceTextController.text = newValue
                                .toStringAsFixed(2); // Masofani belgilash uchun
                          },
                          child: Container(
                            width: 40,
                            height: 40,
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
              const SizedBox(height: 10),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      'Qolgan foyda',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 75, 75, 75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        calculatedUzsPrice="";
                        convertTextController.text=benefit;
                        _showBottomSheet(
                            context); // Show bottom sheet on button press
                      },
                      child: const Text("so`mda ko`rish",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                          )),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(benefit.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Wrap(
                spacing: 8.0,

                children: List<Widget>.generate(collectionList.length, (index) {
                  final groupNumber = index + 1;
                  return FilterChip(
                    visualDensity: VisualDensity.comfortable,
                    selectedColor: const Color(0xFF00C643), // Set sel
                    checkmarkColor: Colors.white,// ected color
                    iconTheme: IconThemeData(color: Colors.white),
                    showCheckmark: false, // Remove the checkmark
                    backgroundColor: Colors.grey[300], // Set default background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide.none, // Remove the border
                    ),
                    label: selectedGroup==groupNumber?Padding(
                      padding: const EdgeInsets.all(1),
                      child: Text(
                        collectionList[index] ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                      ),
                    ):Padding(
                      padding: const EdgeInsets.all(1),
                      child: Text(
                        collectionList[index] ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                          letterSpacing: -0.33,
                        ),
                      ),
                    ),
                    selected: selectedGroup == groupNumber,
                    onSelected: (isSelected) {
                      setState(() {
                        selectedGroup = isSelected ? groupNumber :groupNumber; // Toggle chip selection
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),
              Container(
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

                        curtainWidth=widthTextController.text.toString();
                        curtainPriceForSelling=meterPriceController.text.toString();
                        curtainSellPrice=sellPriceTextController.text.toString();
                        curtainRealPrice=calculatedPrice.toString();
                        curtainHeight=heightTextController.text.toString();
                        collectionType=collectionList[selectedGroup-1];
                        print(collectionType);
                        if(curtainWidth.isEmpty|curtainPriceForSelling.isEmpty|curtainSellPrice.isEmpty|curtainRealPrice.isEmpty|curtainHeight.isEmpty|collectionType.isEmpty){
                          SnackbarUtils.showSnackbar(context, "Maydonlar bo`sh");
                        }else{
                          currentStep < 2 ? currentStep += 1 : null;
                        }

                      });
                    },
                    child: Container(
                      width: 360,
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Keyingisi',
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
              )
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          state: currentStep == 1 ? StepState.indexed : StepState.complete,
          title: Text(''),
          content: Column(
            children: [
              TextField(

                readOnly: true,

                keyboardType: TextInputType.none,
                onTap: ()async{
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      curtainDateTextController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }

                },
                controller: curtainDateTextController,
                decoration: InputDecoration(

                  contentPadding: const EdgeInsets.all(20),
                  suffixIcon: IconButton(
                      onPressed: () async{
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            curtainDateTextController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                          });
                        }

                      },
                      icon: const Icon(
                        FluentIcons.calendar_16_regular,
                        size: 30,
                      )),
                  labelText: 'Current Date',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // TextField(
              //   readOnly: true,
              //   onTap: ()async{
              //     final selectedDate = await showDatePicker(
              //       context: context,
              //       initialDate: DateTime.now(),
              //       firstDate: DateTime.now(),
              //       lastDate: DateTime(2030),
              //     );
              //     if (selectedDate != null) {
              //       setState(() {
              //         finishDateTextController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
              //       });
              //     }
              //
              //   },
              //
              //   controller: finishDateTextController,
              //   decoration: InputDecoration(
              //     contentPadding: const EdgeInsets.all(20),
              //     suffixIcon: IconButton(
              //         onPressed: ()async{
              //           final selectedDate = await showDatePicker(
              //             context: context,
              //             initialDate: DateTime.now(),
              //             firstDate: DateTime.now(),
              //             lastDate: DateTime(2030),
              //           );
              //           if (selectedDate != null) {
              //             setState(() {
              //               finishDateTextController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
              //             });
              //           }
              //
              //         },
              //         icon: const Icon(
              //           FluentIcons.calendar_16_regular,
              //           size: 30,
              //         )),
              //     labelText: 'Finished Date',
              //     border: const OutlineInputBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(15)),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // AppStyle.divider,
              // const SizedBox(
              //   height: 20,
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   child: Row(
              //     children: [
              //       Text(
              //         'Order Status',
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Color.fromARGB(255, 75, 75, 75),
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //       Spacer(),
              //       Icon(
              //         Icons.keyboard_arrow_down_rounded,
              //         color: Color.fromARGB(255, 75, 75, 75),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Wrap(
              //   spacing: 8.0,
              //
              //   children: List<Widget>.generate(statusList.length, (index) {
              //     final groupNumber = index + 1;
              //     return FilterChip(
              //       visualDensity: VisualDensity.comfortable,
              //       selectedColor: const Color(0xFF00C643), // Set sel
              //       checkmarkColor: Colors.white,// ected color
              //       iconTheme: IconThemeData(color: Colors.white),
              //       showCheckmark: false, // Remove the checkmark
              //       backgroundColor: Colors.grey[300], // Set default background color
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //         side: BorderSide.none, // Remove the border
              //       ),
              //       label: selectedGroupForStatus==groupNumber?Padding(
              //         padding: const EdgeInsets.all(1),
              //         child: Text(
              //           '${statusList[index]}',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 14,
              //             fontFamily: 'Poppins',
              //             fontWeight: FontWeight.w500,
              //             height: 0,
              //             letterSpacing: -0.33,
              //           ),
              //         ),
              //       ):Padding(
              //         padding: const EdgeInsets.all(1),
              //         child: Text(
              //           '${statusList[index]}',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 14,
              //             fontFamily: 'Poppins',
              //             fontWeight: FontWeight.w500,
              //             height: 0,
              //             letterSpacing: -0.33,
              //           ),
              //         ),
              //       ),
              //       selected: selectedGroupForStatus == groupNumber,
              //       onSelected: (isSelected) {
              //         setState(() {
              //           selectedGroupForStatus = isSelected ? groupNumber :groupNumber; // Toggle chip selection
              //         });
              //       },
              //     );
              //   }),
              // ),

              const SizedBox(
                height: 20,
              ),
              AppStyle.divider,
              const SizedBox(
                height: 20,
              ),
              Container(
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
                      var product=Product(curtainHeight: curtainHeight, curtainWidth: curtainWidth, curtainPriceForSelling: curtainPriceForSelling, curtainRealPrice: curtainRealPrice, curtainSellPrice: curtainSellPrice, benefit: benefit, createdDate:curtainDateTextController.text, finishDate: finishDateTextController.text, collectionType: collectionType, status:statusList[selectedGroupForStatus-1]);

                      addBloc.add(AddProductEvent(product: product));

                    },
                    child: Container(
                      width: 360,
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Saqlash',
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
              )
            ],
          ),
        ),
        Step(
          isActive: currentStep == 2,
          title: Text(''),
          content: Column(),
        )
      ];

  void _calculateBenefit(){
    double realPrice = double.parse(calculatedPrice.replaceAll('\$', '')); // Parsing as double
    double sellPrice = double.parse(sellPriceTextController.text.replaceAll('\$', '')); // Assuming sellPrice is an integer

    setState(() {
       benefit = "${sellPrice -realPrice}\$";

    });
    }
  void _onMeterPriceChanged() {
    // Access the updated text using meterPriceController.text
    double price = double.parse(meterPriceController.text);
    double height = double.parse(heightTextController.text);
    double width = double.parse(widthTextController.text);
    double calculate = price * height * width;
    calculatedPrice = "${calculate.toString()}\$";
    sellPriceTextController.text=calculate.toDouble().toString();

    print("after $calculatedPrice");
    setState(() {});

    // For example, update the calculated price based on the new value
  }
  void _onDoubleTap(BuildContext context) {
    _clickTimer?.cancel(); // Cancel previous timer if any

    backClickCounter++;

    if (backClickCounter == 1) {
      SnackbarUtils.showSnackbar(context, "Qayta bosing");
    } else {
      _clickTimer = Timer(Duration(milliseconds: 500), () {
        closeScreen(context);
        backClickCounter = 0;
      });
    }
  }

  @override
  void dispose() {
    _clickTimer?.cancel(); // Cancel timer when the widget is disposed
    super.dispose();
  }

  void fetchData() async {
    var url = Uri.parse('http://cbu.uz/uzc/arkhiv-kursov-valyut/json/');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Currency> currenciesres = (jsonData as List)
            .map((currency) => Currency.fromJson(currency))
            .toList();
        currencies=currenciesres;
        loading=false;
      } else {
        print('Yuklay olmadi.');
        loading=false;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Widget build method and other parts of your class...
  void _showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        if (loading!=true) {
          return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            currencies?.forEach((element) {
              print(element.name);
            });
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
                    controller: convertTextController,
                    decoration: const InputDecoration(

                      labelText: 'USD dollar kiriting',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                 const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Perform your conversion logic here
                      var cprice = double.parse(currencies![0].rate!) *
                          double.parse(convertTextController.text.replaceAll('\$', ''));
                      String formattedNumber = NumberFormat('#,##0.#########').format(cprice);
                      setState(() {
                        calculatedUzsPrice = "$formattedNumber so`m";
                        print(calculatedUzsPrice);
                      });
                        },
                    child: Text('Convert'),
                  ),
                  AppStyle.divider,
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Text(
                          'Hisoblangan narx',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 75, 75, 75),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),

                        Text(calculatedUzsPrice,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        );
        }
        else {
          return Container(child: Center(child: CircularProgressIndicator(),),);
        }
      },
    );
  }
}

// Stepper(
//             elevation: 0,
//             connectorThickness: 2,
//             steps: stepList(),
//             type: StepperType.horizontal,
//           ),
