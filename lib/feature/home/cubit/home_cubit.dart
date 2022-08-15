import 'package:equatable/equatable.dart';
import 'package:fellow/fellow.dart';
import 'package:fellow/utility/page_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/network_manager.dart';
import '../../../service/project_network_manager.dart';
import '../model/data_model.dart';
import '../model/failure_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final INetworkManager networkManager = INetworkManager(ProjectNetworkManager.instance.service);

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

  void pageRoute(BuildContext context, Widget page, Map<String, dynamic> formData) async {
    final response = await context.navToPage(page, type: SlideType.LEFT);
    if (response == true) {
      await fetchData(formData);
    }
  }
}
