

import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/employee_cubit.dart';

class AppModule extends Module
{
  @override
  List<Bind<Object>> get binds => [
    Bind.singleton<EmployeeCubit>((i) => EmployeeCubit()),
  ];
}