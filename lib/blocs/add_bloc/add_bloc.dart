import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../core/db/myDb.dart';
import 'add_event.dart';
import 'add_state.dart';
import 'add_state.dart';


class AddBloc extends Bloc<AddEvent, AddState> {
  final MyDb myDb;
  AddBloc({required this.myDb}) : super(AddIntial()) {
    on<InitEvenet>((event, emit) {
      emit(AddIntial());
    });
    on<AddProductEvent>((event, emit) async {
      emit(Loading());
      try{
        var addProduct = await myDb.addProduct(event.product);
        emit(AddSuccessState(message: addProduct.toString()));
      }
      catch(e){
        emit(ErrorLoad(error: e.toString()));
      }
    });
  }
}
