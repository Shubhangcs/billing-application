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
import 'package:new_billing/core/widgets/app_delete_confirmation_bottom_sheet.dart';
import 'package:new_billing/features/logistic/presentation/widgets/add_logistic_form.dart';
import 'package:new_billing/features/logistic/presentation/widgets/logistic_tile.dart';

class LogisticsPage extends StatefulWidget {
  const LogisticsPage({super.key});

  @override
  State<LogisticsPage> createState() => _LogisticsPageState();
}

class _LogisticsPageState extends State<LogisticsPage> {
  void _showAddLogisticBottomsheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AddLogisticForm(),
    );
  }

  void _showDeleteBottomsheet({
    required String logisticsName,
    required String logisticsAddress,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AppDeleteConfirmationBottomSheet(
        title: logisticsName,
        subtitle: logisticsAddress,
        onDeletePressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logistics"),
      ),
      body: SingleChildScrollView(
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
                    logisticName: "Prajwal Andanur",
                    logisticPhoneNumber: "8618245446",
                    onDeletePressed: () {
                      _showDeleteBottomsheet(
                        logisticsName: "Prajwal Andanur",
                        logisticsAddress: "Shobhavana Campus, Mijar.",
                      );
                    },
                    logisticAddress: "Shobhavana Campus, Mijar.",
                    logisticGstNumber: "3721678ewjedhwjq",
                    logisticState: "Karnataka",
                  );
                },
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddLogisticBottomsheet();
        },
        child: Icon(
          Icons.add_rounded,
        ),
      ),
    );
  }
}
