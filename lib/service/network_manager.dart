import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/info_message.dart';
import '../../../core/connectivity.dart';
import '../constant/app_constant.dart';
import 'interface/network_model.dart';

abstract class NetworkManager with ToastMessage {
  NetworkManager(this.dio);
  final Dio dio;

  Future fetchData<T extends INetworkModel, R>(FormData formData, {required T model});
}

enum _INetworkManagerPaths { process }

class INetworkManager extends NetworkManager {
  INetworkManager(super.dio);

  @override
  Future fetchData<T extends INetworkModel, R>(FormData formData, {required T model}) async {
    final bool networkConnection = await Connectivity().check();

    if (networkConnection == false) {
      ToastMessage.showToast("İnternet bağlantısı yok!", ToastType.error.name);
    } else {
      try {
        final response = await dio.post(_INetworkManagerPaths.process.name, data: formData).timeout(
              Duration(seconds: AppConstant.instance.queryTimeOut),
            );

        if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
          ToastMessage.showToast("Başarılı!", ToastType.success.name);
          final jsonBody = response.data;
          if (jsonBody is List) {
            return jsonBody.map((json) => model.fromJson(json)).cast<T>().toList();
          } else {
            ToastMessage.showToast("Bir hata oluştu!", ToastType.error.name);
          }
        } else {
          ToastMessage.showToast("Sunucuya ulaşılamıyor!", ToastType.error.name);
        }
      } on TimeoutException catch (_) {
        ToastMessage.showToast("Bir hata oluştu!", ToastType.error.name);
      } on DioError catch (error) {
        _ShowDebug.showDioError(error, this);
      }
    }
    return null;
  }
}

class _ShowDebug {
  static void showDioError<T>(DioError error, T type) {
    if (kDebugMode) {
      print(error.message);
      print(type);
      print("-----------------------------");
    }
  }
}
