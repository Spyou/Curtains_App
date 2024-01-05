// part of 'home_bloc.dart';

import 'package:curtains_app/core/model/product.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class GetHomeList extends HomeState {
  List<Product> homeList;
  GetHomeList({required this.homeList});

}
class LoadingHomeState extends HomeState{

}
class HomeErrorState extends HomeState{
  String error;
  HomeErrorState({required this.error});
}