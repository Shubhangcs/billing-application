import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:new_billing/core/common/widgets/app_bar.dart";
import "package:new_billing/core/common/widgets/custom_snackbar.dart";
import "package:new_billing/core/common/widgets/elevated_button.dart";
import "package:new_billing/core/common/widgets/text_field.dart";
import "package:new_billing/features/new_customer/bloc/customer_bloc.dart";

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerAddressController =
      TextEditingController();
  final TextEditingController _customerGstinController =
      TextEditingController();
  final TextEditingController _customerPhoneNumberController =
      TextEditingController();
  final TextEditingController _customerStateController =
      TextEditingController();
  final TextEditingController _customerStateCodeController =
      TextEditingController();

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerAddressController.dispose();
    _customerGstinController.dispose();
    _customerPhoneNumberController.dispose();
    _customerStateCodeController.dispose();
    _customerStateController.dispose();
    super.dispose();
  }

  void _clearControllers() {
    _customerNameController.clear();
    _customerAddressController.clear();
    _customerGstinController.clear();
    _customerPhoneNumberController.clear();
    _customerStateCodeController.clear();
    _customerStateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if(state is AddCustomerSuccessState){
          CustomSnackbar.snackbarShow(context, state.message);
          _clearControllers();
          return;
        }
        if(state is AddCustomerFailedState){
          CustomSnackbar.snackbarShow(context, state.message);
          return;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar().build(context),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: "Customer Name",
                  controller: _customerNameController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: "Customer Address",
                  controller: _customerAddressController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: "Customer GSTIN",
                  controller: _customerGstinController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: "Customer Phone Number",
                  controller: _customerPhoneNumberController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: "Customer State",
                  controller: _customerStateController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: "Customer State Code",
                  controller: _customerStateCodeController,
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<CustomerBloc, CustomerState>(
                  builder: (context, state) {
                    return CustomElevatedButton(
                      isLoading: state is CustomerLoadingState,
                      buttonText: "Add Customer",
                      onPressed: () {
                        context.read<CustomerBloc>().add(
                              AddCustomerEvent(
                                customerName: _customerNameController.text,
                                customerAddress: _customerAddressController.text,
                                customerGSTIN: _customerGstinController.text,
                                customerPhoneNumber:
                                    _customerPhoneNumberController.text,
                                customerState: _customerStateController.text,
                                customerStateCode:
                                    _customerStateCodeController.text,
                              ),
                            );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
