import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../../../core/info_message.dart';
import '../../../core/connectivity.dart';
import '../constant/app_constant.dart';
import 'interface/network_model.dart';

abstract class NetworkManager with ToastMessage {
  NetworkManager(this.client);
  final http.Client client;

  Future fetchData<T extends INetworkModel, R>(Map<String, dynamic>? formData, {required T model});
  Future saveData<T extends INetworkModel, R>(Map<String, dynamic>? formData, {required T model});
}

class INetworkManager extends NetworkManager {
  INetworkManager(super.client);

  @override
  Future fetchData<T extends INetworkModel, R>(Map<String, dynamic>? formData, {required T model}) async {
    final bool networkConnection = await Connectivity().check();

    if (networkConnection == false) {
      ToastMessage.showToast("İnternet bağlantısı yok!", ToastType.error.name);
    } else {
      try {
        final response = await client.post(Uri.parse(AppConstant.instance.baseUrl), body: formData).timeout(
              Duration(seconds: AppConstant.instance.queryTimeOut),
            );

        if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
          final jsonBody = response.body;
          if (jsonBody.isNotEmpty) {
            return (json.decode(jsonBody) as List).map((json) => model.fromJson(json)).cast<T>().toList();
          } else {
            ToastMessage.showToast("Bir hata oluştu!", ToastType.error.name);
          }
        } else {
          ToastMessage.showToast("Sunucuya ulaşılamıyor!", ToastType.error.name);
        }
      } on TimeoutException catch (_) {
        ToastMessage.showToast("Bir hata oluştu!", ToastType.error.name);
      } catch (error) {
        _ShowDebug.showDioError(error, this);
      }
    }
    return null;
  }

  @override
  Future saveData<T extends INetworkModel, R>(Map<String, dynamic>? formData, {required T model}) async {
    final bool networkConnection = await Connectivity().check();

    if (networkConnection == false) {
      ToastMessage.showToast("İnternet bağlantısı yok!", ToastType.error.name);
    } else {
      try {
        final response = await client.post(Uri.parse(AppConstant.instance.baseUrl), body: formData).timeout(
              Duration(seconds: AppConstant.instance.queryTimeOut),
            );

        if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
          final jsonBody = response.body;
          if (jsonBody.isNotEmpty) {
            return (json.decode(jsonBody) as List).map((json) => model.fromJson(json)).cast<T>().toList();
          } else {
            ToastMessage.showToast("Bir hata oluştu!", ToastType.error.name);
          }
        } else {
          ToastMessage.showToast("Sunucuya ulaşılamıyor!", ToastType.error.name);
        }
      } on TimeoutException catch (_) {
        ToastMessage.showToast("Bir hata oluştu!", ToastType.error.name);
      } catch (error) {
        _ShowDebug.showDioError(error, this);
      }
    }
    return null;
  }
}

class _ShowDebug {
  static void showDioError<T>(error, T type) {
    if (kDebugMode) {
      print(error.message);
      print(type);
      print("-----------------------------");
    }
  }
}
