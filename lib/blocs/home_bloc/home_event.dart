

import 'package:flutter/cupertino.dart';

import '../../core/model/product.dart';

@immutable
abstract class HomeEvent {}
class InitEvenet extends HomeEvent {

}class GetHomeList extends HomeEvent {
}
class OnErrorEvent extends HomeEvent{}
