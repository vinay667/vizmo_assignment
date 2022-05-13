import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vizmo_assignment/widget/loader_widget.dart';

import '../utils/colors.dart';
import '../bloc/employee_cubit.dart';

class EmployeeDetails extends StatefulWidget {
  final String employeeID;

  EmployeeDetails(this.employeeID);

  EmployeeDetailsState createState() => EmployeeDetailsState();
}

class EmployeeDetailsState extends State<EmployeeDetails> {
  final employeeBloc = Modular.get<EmployeeCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employee Details'),
          backgroundColor: MyColor.appTheme,
        ),
        body: BlocBuilder(
            bloc: employeeBloc,
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: 20),
                  employeeBloc.state.isLoading
                      ? Center(
                    child: LoaderWidget(),
                  )
                      : Card(
                          shadowColor: Colors.tealAccent,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          elevation: 4,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28, // Image radius
                                  backgroundImage: NetworkImage(
                                      employeeBloc.state.detailModel?.avatar ??
                                          ''),
                                ),
                                const SizedBox(width: 17),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      employeeBloc.state.detailModel?.name ??
                                          '',
                                      style:const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      employeeBloc.state.detailModel?.phone ??
                                          '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.deepPurpleAccent),
                                    ),
                                    const SizedBox(height: 2),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          employeeBloc
                                                  .state.detailModel?.email ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.brown,
                                              fontStyle: FontStyle.italic),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    const SizedBox(height: 2),
                                    Text(
                                      employeeBloc.state.detailModel?.country ??
                                          '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              );
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeBloc.fetchEmployeeDetails('/employee/'+widget.employeeID, context);
  }
}
