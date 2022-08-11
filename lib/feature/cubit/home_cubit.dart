// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/network_manager.dart';
import '../home/model/data_model.dart';
import '../home/model/failure_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<DataModel>? items;

  Future<void> fetchData(INetworkManager networkManager, FormData formData) async {
    emit(FetchLoading());
    try {
      final response = await networkManager.fetchData<DataModel, DataModel>(formData, model: DataModel());
      emit(FetchLoaded(items: response));
    } on Failure catch (err) {
      emit(FetchError(failure: err));
    } catch (err) {
      print("failure : $err");
    }
  }

  Future<void> itemDetail(String id) async {}
}
