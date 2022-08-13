import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/crypt.dart';
import '../../../service/network_manager.dart';
import '../../../service/project_network_manager.dart';
import '../model/data_model.dart';
import '../model/failure_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final INetworkManager networkManager = INetworkManager(ProjectNetworkManager.instance.service);

  List<DataModel>? items;

  Map<String, dynamic> data = {
    'frmID': Crypt().encrypt("dioTest"),
    'id': Crypt().encrypt("1"),
    'token': Crypt().encrypt("nRJZ3ctCZVAWzFTA")
  };

  Future<void> fetchData(Map<String, dynamic>? formData) async {
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
}
