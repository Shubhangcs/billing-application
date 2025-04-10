// import "package:flutter/material.dart";
// import "package:flutter_bloc/flutter_bloc.dart";
// import "package:new_billing/core/common/widgets/app_bar.dart";
// import "package:new_billing/core/common/widgets/custom_snackbar.dart";
// import "package:new_billing/core/common/widgets/elevated_button.dart";
// import "package:new_billing/core/common/widgets/text_field.dart";
// import "package:new_billing/features/customer/presentation/bloc/customer_bloc.dart";

// class CustomerPage extends StatefulWidget {
//   const CustomerPage({super.key});

//   @override
//   State<CustomerPage> createState() => _CustomerPageState();
// }

// class _CustomerPageState extends State<CustomerPage> {
//   final TextEditingController _customerNameController = TextEditingController();
//   final TextEditingController _customerAddressController =
//       TextEditingController();
//   final TextEditingController _customerGstinController =
//       TextEditingController();
//   final TextEditingController _customerPhoneNumberController =
//       TextEditingController();
//   final TextEditingController _customerStateController =
//       TextEditingController();
//   final TextEditingController _customerStateCodeController =
//       TextEditingController();

//   @override
//   void dispose() {
//     _customerNameController.dispose();
//     _customerAddressController.dispose();
//     _customerGstinController.dispose();
//     _customerPhoneNumberController.dispose();
//     _customerStateCodeController.dispose();
//     _customerStateController.dispose();
//     super.dispose();
//   }

//   void _clearControllers() {
//     _customerNameController.clear();
//     _customerAddressController.clear();
//     _customerGstinController.clear();
//     _customerPhoneNumberController.clear();
//     _customerStateCodeController.clear();
//     _customerStateController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CustomerBloc, CustomerState>(
//       listener: (context, state) {
//         if(state is AddCustomerSuccessState){
//           CustomSnackbar.snackbarShow(context, state.message);
//           _clearControllers();
//           return;
//         }
//         if(state is AddCustomerFailedState){
//           CustomSnackbar.snackbarShow(context, state.message);
//           return;
//         }
//       },
//       child: Scaffold(
//         appBar: CustomAppBar().build(context),
//         body: Padding(
//           padding: EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomTextField(
//                   maxLength: 46,
//                   labelText: "Customer Name",
//                   controller: _customerNameController,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomTextField(
//                   maxLength: 46,
//                   labelText: "Customer Address",
//                   controller: _customerAddressController,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomTextField(
//                   maxLength: 15,
//                   labelText: "Customer GSTIN",
//                   controller: _customerGstinController,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomTextField(
//                   maxLength: 10,
//                   labelText: "Customer Phone Number",
//                   controller: _customerPhoneNumberController,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomTextField(
//                   maxLength: 46,
//                   labelText: "Customer State",
//                   controller: _customerStateController,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CustomTextField(
//                   maxLength: 5,
//                   labelText: "Customer State Code",
//                   controller: _customerStateCodeController,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 BlocBuilder<CustomerBloc, CustomerState>(
//                   builder: (context, state) {
//                     return CustomElevatedButton(
//                       isLoading: state is CustomerLoadingState,
//                       buttonText: "Add Customer",
//                       onPressed: () {
//                         context.read<CustomerBloc>().add(
//                               AddCustomerEvent(
//                                 customerName: _customerNameController.text,
//                                 customerAddress: _customerAddressController.text,
//                                 customerGSTIN: _customerGstinController.text,
//                                 customerPhoneNumber:
//                                     _customerPhoneNumberController.text,
//                                 customerState: _customerStateController.text,
//                                 customerStateCode:
//                                     _customerStateCodeController.text,
//                               ),
//                             );
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
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
import 'package:new_billing/features/customer/presentation/cubit/add_customer_cubit.dart';
import 'package:new_billing/features/customer/presentation/cubit/delete_customer_cubit.dart';
import 'package:new_billing/features/customer/presentation/cubit/fetch_customer_cubit.dart';
import 'package:new_billing/features/customer/presentation/widgets/add_customer_form.dart';
import 'package:new_billing/features/customer/presentation/widgets/customer_page_loading_widget.dart';
import 'package:new_billing/features/customer/presentation/widgets/customer_tile.dart';
import 'package:new_billing/init_dependencies.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerStateController =
      TextEditingController();
  final TextEditingController _customerStateCodeController =
      TextEditingController();
  final TextEditingController _customerGstInController =
      TextEditingController();
  final TextEditingController _customerAddressController =
      TextEditingController();

  @override
  void initState() {
    _fetchCustomers();
    super.initState();
  }

  void _fetchCustomers() {
    BlocProvider.of<FetchCustomerCubit>(context).fetchCustomers();
  }

  void _clearControllers() {
    _customerNameController.clear();
    _customerAddressController.clear();
    _customerGstInController.clear();
    _customerStateController.clear();
    _customerStateCodeController.clear();
  }

  void _showAddCustomerBottomsheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => serviceLocator<AddCustomerCubit>(),
        child: BlocBuilder<AddCustomerCubit, AddCustomerState>(
          builder: (context, state) {
            return BlocListener<AddCustomerCubit, AddCustomerState>(
              listener: (context, state) {
                if (state is AddCustomerSuccessState) {
                  Navigator.pop(context);
                  _fetchCustomers();
                  _clearControllers();
                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar(message: state.message).build(context),
                  );
                }
                if (state is AddCustomerFailureState) {
                  Navigator.pop(context);
                  _fetchCustomers();
                  _clearControllers();
                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar(message: state.message).build(context),
                  );
                }
              },
              child: AddCustomerForm(
                customerNameController: _customerNameController,
                customerAddressController: _customerAddressController,
                customerGstInController: _customerGstInController,
                customerStateController: _customerStateController,
                customerStateCodeController: _customerStateCodeController,
                isLoading: state is AddCustomerLoadingState,
                onPressed: () {
                  BlocProvider.of<AddCustomerCubit>(context).addCustomer(
                    customerName: _customerNameController.text,
                    customerAddress: _customerAddressController.text,
                    customerGstNumber: _customerGstInController.text,
                    customerState: _customerStateController.text,
                    customerStateCode: _customerStateCodeController.text,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteBottomsheet({
    required String customerName,
    required String customerAddress,
    required String customerId,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => serviceLocator<DeleteCustomerCubit>(),
        child: BlocBuilder<DeleteCustomerCubit, DeleteCustomerState>(
          builder: (context, state) {
            return BlocListener<DeleteCustomerCubit, DeleteCustomerState>(
              listener: (context, state) {
                if (state is DeleteCustomerSuccessState) {
                  Navigator.pop(context);
                  _fetchCustomers();
                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar(message: state.message).build(context),
                  );
                }
                if (state is DeleteCustomerFailureState) {
                  Navigator.pop(context);
                  _fetchCustomers();
                  ScaffoldMessenger.of(context).showSnackBar(
                    AppSnackBar(message: state.message).build(context),
                  );
                }
              },
              child: AppDeleteConfirmationBottomSheet(
                isLoading: state is DeleteCustomerLoadingState,
                title: customerName,
                subtitle: customerAddress,
                onDeletePressed: () {
                  BlocProvider.of<DeleteCustomerCubit>(context).deleteCustomer(
                    customerId: customerId,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer"),
        actions: [
          IconButton(
            onPressed: () {
              _fetchCustomers();
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: BlocBuilder<FetchCustomerCubit, FetchCustomerState>(
        builder: (context, state) {
          if (state is FetchCustomerLoadingState) {
            return CustomerPageLoadingWidget();
          }
          if (state is FetchCustomerFailureState) {
            return AppErrorWidget(
              errorMessage: state.message,
              onPressed: () {
                _fetchCustomers();
              },
            );
          }
          if (state is FetchCustomerSuccessState && state.customers.isEmpty) {
            return AppEmptyWidget(
              errorMessage: "No Customres To Display",
              onPressed: () {
                _fetchCustomers();
              },
            );
          }
          if (state is FetchCustomerSuccessState) {
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment(-1, 0),
                        child: Text(
                          "Customer's",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment(-1, 0),
                        child: Text(
                          "Already Exesting Customer's",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomerTile(
                          customerName: state.customers[index].customerName,
                          customerAddress:
                              state.customers[index].customerAddress,
                          customerGstNumber:
                              state.customers[index].customerGstNumber,
                          customerState: state.customers[index].customerState,
                          onDeletePressed: () {
                            _showDeleteBottomsheet(
                              customerName: state.customers[index].customerName,
                              customerAddress:
                                  state.customers[index].customerAddress,
                              customerId: state.customers[index].customerId,
                            );
                          },
                        );
                      },
                      itemCount: state.customers.length,
                    )
                  ],
                ),
              ),
            );
          }
          return CustomerPageLoadingWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCustomerBottomsheet();
        },
        child: Icon(
          Icons.add_rounded,
        ),
      ),
    );
  }
}
