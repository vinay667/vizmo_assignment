import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vizmo_assignment/bloc/employee_cubit.dart';
import 'package:vizmo_assignment/screens/employee_check_in.dart';
import 'package:vizmo_assignment/screens/employee_detail_screen.dart';

import '../widget/button.dart';
import '../utils/colors.dart';
import '../widget/employee_card.dart';
import '../widget/loader_widget.dart';

class SearchAndFilterScreen extends StatefulWidget {
  const SearchAndFilterScreen({Key? key}) : super(key: key);

  @override
  SearchAndFilterState createState() => SearchAndFilterState();
}

class SearchAndFilterState extends State<SearchAndFilterScreen> {
  final employeeBloc = Modular.get<EmployeeCubit>();
  List<String> sortingItems = ['Select any', 'createdAt', 'desc'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Search And Filter'),
        backgroundColor: MyColor.appTheme,
      ),
      body: BlocBuilder(
          bloc: employeeBloc,
          builder: (context, state) {
            return employeeBloc.state.isLoading
                ? Center(
                    child: LoaderWidget(),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              text: 'Sort By created at',
                              bgColor: Colors.teal,
                              onPressed: () {
                                print(employeeBloc.state.filteredList.length
                                    .toString());
                                employeeBloc.getFilteredData(
                                    '/employee?sortBy=createdAt', context);
                                print(employeeBloc.state.filteredList.length
                                    .toString());
                              },
                            ),
                            CustomButton(
                              text: 'Desc/Asc Order',
                              bgColor: Colors.blue,
                              onPressed: () {
                                employeeBloc.getFilteredData(
                                    '/employee?order=desc', context);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            employeeBloc.getFilteredData(
                                '/employee?country=Paraguay', context);

                            print(employeeBloc.state.filteredList.length
                                .toString());
                          },
                          child: const Text(
                            'Filter by country Paraguay',
                            style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                            child: ListView.builder(
                                itemCount:
                                    employeeBloc.state.filteredList.length,
                                itemBuilder: (BuildContext context, int pos) {
                                  return Column(
                                    children: [
                                      EmployeeCard(
                                        empEmail: employeeBloc
                                            .state.filteredList
                                            .elementAt(pos)
                                            .email,
                                        empName: employeeBloc.state.filteredList
                                            .elementAt(pos)
                                            .name,
                                        empPhone: employeeBloc
                                            .state.filteredList
                                            .elementAt(pos)
                                            .phone,
                                        imageUrl: employeeBloc
                                            .state.filteredList
                                            .elementAt(pos)
                                            .avatar,
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            CustomButton(
                                              text: 'Details',
                                              bgColor: Colors.teal,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EmployeeDetails(
                                                                employeeBloc
                                                                    .state
                                                                    .filteredList[
                                                                        pos]
                                                                    .id)));
                                              },
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomButton(
                                              text: 'Check Ins',
                                              bgColor: Colors.purpleAccent,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EmployeeCheckIn(
                                                                employeeBloc
                                                                    .state
                                                                    .filteredList[
                                                                        pos]
                                                                    .id)));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                })),
                        employeeBloc.state.isLoadingPagination
                            ? Container(
                                color: Colors.white,
                                height: 70,
                                child: Center(child: LoaderWidget()),
                              )
                            : Container()
                      ],
                    ),
                  );
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeBloc.getFilteredData('/employee', context);
  }
}
