import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/info_message.dart';
import '../../../service/network_manager.dart';
import '../../../service/project_network_manager.dart';
import '../../home/model/response_model.dart';
import '../model/failure_model.dart';

part 'homedetail_state.dart';

class HomedetailCubit extends Cubit<HomedetailState> {
  HomedetailCubit() : super(HomedetailInitial());

  final INetworkManager _networkManager = INetworkManager(ProjectNetworkManager.instance.service);
  List<ResponseModel>? items;

  void setInputs(String? text, String? date, {required textController, required dateController}) {
    textController.text = text ?? '';
    dateController.text = date ?? '';
  }

  Future<void> save(Map<String, dynamic>? formData) async {
    emit(SaveLoading());
    final response = await _networkManager.saveData<ResponseModel, ResponseModel>(formData, model: const ResponseModel());

    emit(SaveLoaded(items: response));
    if (response?[0].message == "OK") {
      emit(ShowMessage(message: 'Başarıyla kaydedildi', type: ToastType.success.name));
    }
  }
}
