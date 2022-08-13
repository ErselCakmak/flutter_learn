// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../service/interface/network_model.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataModel extends Equatable with INetworkModel<DataModel> {
  final String? id;
  final String? userID;
  final String? text;
  final String? date;

  DataModel({this.id, this.userID, this.text, this.date});

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DataModelFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() {
    return _$DataModelToJson(this);
  }

  @override
  List<Object?> get props => [id, userID, text, date];
}
