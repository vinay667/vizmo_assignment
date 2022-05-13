import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vizmo_assignment/widget/loader_widget.dart';

import '../utils/colors.dart';
import '../bloc/employee_cubit.dart';

class EmployeeCheckIn extends StatefulWidget {
  final String employeeID;

  EmployeeCheckIn(this.employeeID);

  EmployeeCheckState createState() => EmployeeCheckState();
}

class EmployeeCheckState extends State<EmployeeCheckIn> {
  final employeeBloc = Modular.get<EmployeeCubit>();
  String dropDownValue = 'Select CheckIN ID';
  bool isSingleCheckInSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employee CheckIN Details'),
          backgroundColor: MyColor.appTheme,
        ),
        body: BlocBuilder(
          bloc: employeeBloc,
          builder: (context, state) {
            return employeeBloc.state.isLoading
                ? Center(
                    child: LoaderWidget(),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Select CheckIn ID:',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            ),
                            DropdownButton<String>(
                              selectedItemBuilder: (_) {
                                return employeeBloc.state.checkInIDList
                                    .map((e) => Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          color: Colors.white,
                                          alignment: Alignment.center,
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                    .toList();
                              },
                              value: dropDownValue,
                              icon: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.arrow_drop_down),
                              ),
                              items: employeeBloc.state.checkInIDList
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                );
                              }).toList(),
                              onChanged: (item) {
                                if (item != 'Select CheckIN ID') {
                                  setState(() {
                                    dropDownValue = item!;
                                    isSingleCheckInSelected = true;
                                  });

                                  employeeBloc.fetchCheckInDetails(
                                      '/employee/' +
                                          widget.employeeID +
                                          '/checkin/' +
                                          dropDownValue,
                                      context);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          employeeBloc.fetchEmployeeCheckINData(
                              '/employee/' + widget.employeeID + '/checkin ',
                              context);
                        },
                        child: Text(
                          'Employee ID:' + widget.employeeID,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isSingleCheckInSelected
                          ? Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              elevation: 4,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 17),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text(
                                              'Location:',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              employeeBloc
                                                      .state.empDat?.location ??
                                                  '',
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Text(
                                            employeeBloc
                                                    .state.empDat?.purpose ??
                                                '',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          employeeBloc.state.empDat?.checkin ??
                                              '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.brown,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount:
                                      employeeBloc.state.checkInList.length,
                                  itemBuilder: (BuildContext context, int pos) {
                                    return Column(
                                      children: [
                                        Card(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          elevation: 4,
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 17),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Location:',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .blueGrey),
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                          employeeBloc
                                                              .state
                                                              .checkInList[pos]
                                                              .location,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .teal),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 2),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: Text(
                                                        employeeBloc
                                                            .state
                                                            .checkInList[pos]
                                                            .purpose,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      employeeBloc
                                                          .state
                                                          .checkInList[pos]
                                                          .checkin
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.brown,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    );
                                  }))
                    ],
                  );
          },
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeBloc.fetchEmployeeCheckINData(
        '/employee/' + widget.employeeID + '/checkin ', context);
  }
}
