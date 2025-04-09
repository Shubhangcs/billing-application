// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_billing/core/common/widgets/app_bar.dart';
// import 'package:new_billing/core/common/widgets/custom_snackbar.dart';
// import 'package:new_billing/core/common/widgets/elevated_button.dart';
// import 'package:new_billing/core/common/widgets/text_field.dart';
// import 'package:new_billing/features/logistic/presentation/bloc/shipper_bloc.dart';

// class ShipperPage extends StatefulWidget {
//   const ShipperPage({super.key});

//   @override
//   State<ShipperPage> createState() => _ShipperPageState();
// }

// class _ShipperPageState extends State<ShipperPage> {
//   final TextEditingController _shipperNameController = TextEditingController();
//   final TextEditingController _shipperAddressController =
//       TextEditingController();
//   final TextEditingController _shipperGstinController = TextEditingController();
//   final TextEditingController _shipperPhoneNumberController =
//       TextEditingController();
//   final TextEditingController _shipperStateController = TextEditingController();
//   final TextEditingController _shipperStateCodeController =
//       TextEditingController();

//   @override
//   void dispose() {
//     _shipperNameController.dispose();
//     _shipperAddressController.dispose();
//     _shipperGstinController.dispose();
//     _shipperPhoneNumberController.dispose();
//     _shipperStateController.dispose();
//     _shipperStateCodeController.dispose();
//     super.dispose();
//   }

//   void _cleanControllers() {
//     _shipperNameController.clear();
//     _shipperAddressController.clear();
//     _shipperGstinController.clear();
//     _shipperPhoneNumberController.clear();
//     _shipperStateController.clear();
//     _shipperStateCodeController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar().build(context),
//       body: BlocListener<ShipperBloc, ShipperState>(
//         listener: (context, state) {
//           if(state is AddShipperSuccessState){
//             CustomSnackbar.snackbarShow(context, state.message);
//             _cleanControllers();
//             return;
//           }
//           if(state is AddShipperFailedState){
//             CustomSnackbar.snackbarShow(context, state.message);
//             return;
//           }
//         },
//         child: Padding(
//               padding: EdgeInsets.all(20),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CustomTextField(
//                       maxLength: 46,
//                       labelText: "Shipper Name",
//                       controller: _shipperNameController,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CustomTextField(
//                       maxLength: 46,
//                       labelText: "Shipper Address",
//                       controller: _shipperAddressController,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CustomTextField(
//                       maxLength: 15,
//                       labelText: "Shipper GSTIN",
//                       controller: _shipperGstinController,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CustomTextField(
//                       maxLength: 10,
//                       labelText: "Shipper Phone Number",
//                       controller: _shipperPhoneNumberController,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CustomTextField(
//                       maxLength: 46,
//                       labelText: "Shipper State",
//                       controller: _shipperStateController,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     CustomTextField(
//                       maxLength: 5,
//                       labelText: "Shipper State Code",
//                       controller: _shipperStateCodeController,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     BlocBuilder<ShipperBloc, ShipperState>(
//                       builder: (context, state) {
//                         return CustomElevatedButton(
//                           isLoading: state is ShipperLoadingState,
//                           buttonText: "Add Shipper",
//                           onPressed: () {
//                             context.read<ShipperBloc>().add(
//                                   AddShipperEvent(
//                                     shipperName: _shipperNameController.text,
//                                     shipperAddress: _shipperAddressController.text,
//                                     shipperGSTIN: _shipperGstinController.text,
//                                     shipperPhoneNumber: _shipperPhoneNumberController.text,
//                                     shipperState: _shipperStateController.text,
//                                     shipperStateCode: _shipperStateCodeController.text,
//                                   ),
//                                 );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_billing/core/widgets/app_delete_confirmation_bottom_sheet.dart';
import 'package:new_billing/core/widgets/app_empty_widget.dart';
import 'package:new_billing/core/widgets/app_error_widget.dart';
import 'package:new_billing/core/widgets/app_snack_bar.dart';
import 'package:new_billing/features/logistic/presentation/cubit/add_logistic_cubit.dart';
import 'package:new_billing/features/logistic/presentation/cubit/delete_logistic_cubit.dart';
import 'package:new_billing/features/logistic/presentation/cubit/fetch_logistic_cubit.dart';
import 'package:new_billing/features/logistic/presentation/widgets/add_logistic_form.dart';
import 'package:new_billing/features/logistic/presentation/widgets/logistic_loading_widget.dart';
import 'package:new_billing/features/logistic/presentation/widgets/logistic_tile.dart';
import 'package:new_billing/init_dependencies.dart';

class LogisticsPage extends StatefulWidget {
  const LogisticsPage({super.key});

  @override
  State<LogisticsPage> createState() => _LogisticsPageState();
}

class _LogisticsPageState extends State<LogisticsPage> {
  final TextEditingController _logisticNameController = TextEditingController();
  final TextEditingController _logisticPhoneNumberController =
      TextEditingController();
  final TextEditingController _logisticStateController =
      TextEditingController();
  final TextEditingController _logisticStatecodeController =
      TextEditingController();
  final TextEditingController _logisticGstController = TextEditingController();
  final TextEditingController _logisticAddressController =
      TextEditingController();

  @override
  void initState() {
    BlocProvider.of<FetchLogisticCubit>(context).fetchLogistics();
    super.initState();
  }

  void _showAddLogisticBottomsheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => serviceLocator<AddLogisticCubit>(),
        child: BlocBuilder<AddLogisticCubit, AddLogisticState>(
          builder: (context, state) {
            return AddLogisticForm(
              logisticAddressController: _logisticAddressController,
              logisticNameController: _logisticNameController,
              logisticGstController: _logisticGstController,
              logisticPhone: _logisticPhoneNumberController,
              logisticStateCode: _logisticStatecodeController,
              logisticStateController: _logisticStateController,
              onPressed: () {
                BlocProvider.of<AddLogisticCubit>(context).addLogistic(
                  logisticName: _logisticNameController.text,
                  logisticAddress: _logisticAddressController.text,
                  logisticGstNumber: _logisticGstController.text,
                  logisticPhoneNumber: _logisticPhoneNumberController.text,
                  logisticState: _logisticStateController.text,
                  logisticStateCode: _logisticStatecodeController.text,
                );
              },
              isLoading: state is AddLogisticLoadingState,
            );
          },
        ),
      ),
    );
  }

  void _showDeleteBottomsheet({
    required String logisticsName,
    required String logisticsAddress,
    required String logisticId,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => serviceLocator<DeleteLogisticCubit>(),
        child: BlocBuilder<DeleteLogisticCubit, DeleteLogisticState>(
          builder: (context, state) {
            return BlocListener<DeleteLogisticCubit, DeleteLogisticState>(
              listener: (context, state) {
                if (state is DeleteLogisticSuccessState) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar(message: state.message).build(context),
                  );
                }
                if (state is DeleteLogisticFailureState) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar(message: state.message).build(context),
                  );
                }
              },
              child: AppDeleteConfirmationBottomSheet(
                isLoading: state is DeleteLogisticLoadingState,
                title: logisticsName,
                subtitle: logisticsAddress,
                onDeletePressed: () {
                  BlocProvider.of<DeleteLogisticCubit>(context).deleteLogistic(
                    logisticId: logisticId,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _clearControllers() {
    _logisticStatecodeController.clear();
    _logisticAddressController.clear();
    _logisticGstController.clear();
    _logisticNameController.clear();
    _logisticStatecodeController.clear();
    _logisticPhoneNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddLogisticCubit, AddLogisticState>(
          listener: (context, state) {
            if (state is AddLogisticSuccessState) {
              print(state.message);
              Navigator.pop(context);
              _clearControllers();
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.message).build(context),
              );
              BlocProvider.of<FetchLogisticCubit>(context).fetchLogistics();
            }
            if (state is AddLogisticFailureState) {
              print(state.message);
              Navigator.pop(context);
              _clearControllers();
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.message).build(context),
              );
            }
          },
        ),
        BlocListener<DeleteLogisticCubit, DeleteLogisticState>(
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Logistics"),
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<FetchLogisticCubit>(context).fetchLogistics();
              },
              icon: Icon(
                Icons.refresh_rounded,
              ),
            ),
          ],
        ),
        body: BlocBuilder<FetchLogisticCubit, FetchLogisticState>(
          builder: (context, state) {
            if (state is FetchLogisticLoadingState) {
              return LogisticLoadingWidget();
            }
            if (state is FetchLogisticFailureState) {
              return AppErrorWidget(
                errorMessage: state.message,
                onPressed: () {
                  BlocProvider.of<FetchLogisticCubit>(context).fetchLogistics();
                },
              );
            }
            if (state is FetchLogisticSuccessState && state.logistic.isEmpty) {
              return AppEmptyWidget(
                errorMessage: "No Logistic to Display.",
                onPressed: () {
                  BlocProvider.of<FetchLogisticCubit>(context).fetchLogistics();
                },
              );
            }
            if (state is FetchLogisticSuccessState) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment(-1, 0),
                          child: Text(
                            "Logistic's",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                          alignment: Alignment(-1, 0),
                          child: Text(
                            "Already Exesting Logistic's",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return LogisticTile(
                            logisticName: state.logistic[index].logisticName,
                            logisticPhoneNumber:
                                state.logistic[index].logisticPhoneNumber,
                            onDeletePressed: () {
                              _showDeleteBottomsheet(
                                logisticsName:
                                    state.logistic[index].logisticName,
                                logisticsAddress:
                                    state.logistic[index].logisticAddress,
                                logisticId: state.logistic[index].logisticId,
                              );
                            },
                            logisticAddress:
                                state.logistic[index].logisticAddress,
                            logisticGstNumber:
                                state.logistic[index].logisticGstNumber,
                            logisticState: state.logistic[index].logisticState,
                          );
                        },
                        itemCount: state.logistic.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      )
                    ],
                  ),
                ),
              );
            }
            return LogisticLoadingWidget();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddLogisticBottomsheet();
          },
          child: Icon(
            Icons.add_rounded,
          ),
        ),
      ),
    );
  }
}
