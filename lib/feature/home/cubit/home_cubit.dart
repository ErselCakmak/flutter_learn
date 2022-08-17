import 'package:equatable/equatable.dart';
import 'package:fellow/fellow.dart';
import 'package:fellow/utility/page_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unnecessary_import

import '../../../constant/app_constant.dart';
import '../../../core/crypt.dart';
import '../../../service/network_manager.dart';
import '../../../service/project_network_manager.dart';
import '../model/data_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final INetworkManager networkManager = INetworkManager(ProjectNetworkManager.instance.service);

  Map<String, dynamic> formData = {
    'frmID': Crypt().encrypt("dioTest"),
    'id': Crypt().encrypt("1"),
    'token': Crypt().encrypt(AppConstant.instance.queryKey),
  };

  int _start = 1;
  final int _dataLimit = 15;

  Future<void> loadData() async {
    if (state.allLoaded) return;
    try {
      if (state.status == FetchStatus.initial) {
        formData.addAll({'start': '$_start', 'limit': '$_dataLimit'});
        final data = await _fetchData();
        await Future.microtask(() {
          return emit(
            state.copyWith(data: data, status: FetchStatus.success, allLoaded: false, firstFetched: true),
          );
        });
      } else {
        if (state.status == FetchStatus.loading) return;
        emit(state.copyWith(status: FetchStatus.loading));

        _start = state.data!.length;
        formData.addAll({'start': '$_start', 'limit': '$_dataLimit'});
        final data = await _fetchData();

        return data == null
            ? emit(
                state.copyWith(allLoaded: true),
              )
            : emit(
                state.copyWith(data: List.of(state.data!)..addAll(data), status: FetchStatus.success, allLoaded: false),
              );
      }
    } catch (_) {
      return emit(state.copyWith(status: FetchStatus.failure));
    }
  }

  Future<List<DataModel>?> _fetchData() async {
    return await networkManager.fetchData<DataModel, DataModel>(formData, model: DataModel());
  }

  Future<void> refreshData() async {
    formData.addAll({'start': '1', 'limit': '$_dataLimit'});
    final data = await _fetchData();
    await Future.microtask(() {
      return emit(HomeState(data: data, status: FetchStatus.success, allLoaded: false, firstFetched: true));
    });
  }

  void pageRoute(BuildContext context, Widget page) async {
    final response = await context.navToPage(page, type: SlideType.LEFT);
    if (response == true) {
      refreshData();
    }
  }
}
