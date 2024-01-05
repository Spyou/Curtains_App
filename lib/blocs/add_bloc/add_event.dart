

import 'package:flutter/cupertino.dart';

import '../../core/model/product.dart';

@immutable
abstract class AddEvent {}
class InitEvenet extends AddEvent {

}class AddProductEvent extends AddEvent {
  Product product;
  AddProductEvent({required this.product});
}
class OnErrorEvent extends AddEvent{}
