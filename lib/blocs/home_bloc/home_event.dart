

import 'package:flutter/cupertino.dart';

import '../../core/model/product.dart';

@immutable
abstract class HomeEvent {}

class GetHomeListEvent extends HomeEvent {
}
class OnErrorEvent extends HomeEvent{}
