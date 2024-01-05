import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:curtains_app/core/db/myDb.dart';
import 'package:meta/meta.dart';

import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MyDb myDb;
  HomeBloc({required this.myDb}) : super(HomeInitial()) {
    on<GetHomeListEvent>((event, emit) async{
      emit(LoadingHomeState());
      try{
        var products= await myDb.getAllProducts();
        emit(GetHomeList(homeList: products));
      }
      catch(e){
        emit(HomeErrorState(error: e.toString()));
      }
    });
  }
}
