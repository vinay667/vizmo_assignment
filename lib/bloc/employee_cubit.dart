import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vizmo_assignment/network/api_helper.dart';
import 'package:vizmo_assignment/models/checkin_model.dart';

import '../models/employee_detail_model.dart';
import '../network/employee_model.dart';

part 'employee_state.dart';

part 'employee_cubit.freezed.dart';

class EmployeeCubit extends Cubit<EmployeeStateFinal> {
  ApiBaseHelper helper = ApiBaseHelper();

  EmployeeCubit() : super(const EmployeeStateFinal());

  fetchEmployeeData(
      String urlEndPoint, BuildContext context, bool loadMainLoader) async {
    if (loadMainLoader) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isLoadingPagination: true));
    }
    var response = await helper.get(urlEndPoint, context);
    final rawList = json.decode(response.body);
    EmployeeResponseModel empList = EmployeeResponseModel.fromJson(rawList);
    if (empList.list.isEmpty) {
      emit(state.copyWith(loadMoreData: false));
    }

    List<Data> homeList = [];

    if (state.list.isNotEmpty) {
      homeList.addAll(state.list);
      homeList.addAll(empList.list);
    } else {
      homeList.addAll(empList.list);
    }

    if (loadMainLoader) {
      emit(state.copyWith(isLoading: false, list: homeList));
    } else {
      emit(state.copyWith(isLoadingPagination: false, list: homeList));
    }
  }

  fetchEmployeeDetails(String urlEndPoint, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    var response = await helper.get(urlEndPoint, context);
    DetailModel empData = DetailModel.fromJson(json.decode(response.body));
    emit(state.copyWith(isLoading: false, detailModel: empData));
  }

  fetchEmployeeCheckINData(String urlEndPoint, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    var response = await helper.get(urlEndPoint, context);
    final checkInList = json.decode(response.body);
    CheckInResponseModel modelList = CheckInResponseModel.fromJson(checkInList);
    List<String> checkINIDs = [];
    checkINIDs.add('Select CheckIN ID');
    for (int i = 0; i < modelList.list.length; i++) {
      checkINIDs.add(modelList.list[i].id);
    }
    emit(state.copyWith(
        isLoading: false,
        checkInList: modelList.list,
        checkInIDList: checkINIDs));
  }

  fetchCheckInDetails(String urlEndPoint, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    var response = await helper.get(urlEndPoint, context);
    EmployeeCheckIN empData =
        EmployeeCheckIN.fromJson(json.decode(response.body));
    emit(state.copyWith(isLoading: false, empDat: empData));
  }

  getFilteredData(String urlEndPoint, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    var response = await helper.get(urlEndPoint, context);
    final checkInList = json.decode(response.body);
    EmployeeResponseModel modelList =
        EmployeeResponseModel.fromJson(checkInList);
    emit(state.copyWith(isLoading: false, filteredList: modelList.list));
  }
}
