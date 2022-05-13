part of '../bloc/employee_cubit.dart';

@freezed
class EmployeeStateFinal with _$EmployeeStateFinal {
  const factory EmployeeStateFinal({
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingPagination,
    @Default("") String errorMsg,
    @Default([]) List<Data> list,
    @Default([]) List<Data> filteredList,
    Data? empData,
    @Default([]) List<EmployeeCheckIN> checkInList,
    @Default([]) List<String> checkInIDList,
    EmployeeCheckIN? empDat,
    DetailModel? detailModel,
    @Default(true) bool loadMoreData,
  }) = _EmployeeStateFinal;
}
