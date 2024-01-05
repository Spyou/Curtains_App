

import 'package:flutter/cupertino.dart';

@immutable
abstract class  AddState {}

class AddIntial extends AddState {}

class Loading extends AddState {}

// ignore: must_be_immutable
class AddSuccessState extends AddState {
  String message;
  AddSuccessState({required this.message});
}

class ErrorLoad extends AddState {
  final String error;
  ErrorLoad({required this.error});
}
