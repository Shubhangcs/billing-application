import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/common/widgets/custom_map_dropdown.dart';
import 'package:new_billing/core/common/widgets/custom_snackbar.dart';
import 'package:new_billing/core/common/widgets/drop_down.dart';
import 'package:new_billing/core/common/widgets/elevated_button.dart';
import 'package:new_billing/core/common/widgets/text_field.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/features/authentication/widgets/styled_icon.dart';
import 'package:new_billing/features/billing/bloc/invoice_bloc.dart';
import 'package:new_billing/features/billing/bloc/invoice_details_bloc.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  void initState() {
    context.read<InvoiceDetailsBloc>().add(InitialInvoiceDetailsFetchEvent());
    super.initState();
  }

  // Controllers for Fields
  final TextEditingController _invoiceNameController = TextEditingController();
  final TextEditingController _invoiceStateNameController =
      TextEditingController();
  final TextEditingController _invoiceStateCodeController =
      TextEditingController();
  final TextEditingController _placeOfSupplyController =
      TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();
  final TextEditingController  _chalanNoController = TextEditingController();
  final TextEditingController _reverseChargeController =
      TextEditingController();
  final TextEditingController _billedToController = TextEditingController();
  final TextEditingController _shippedByController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // Date Picker Function
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  @override
  void dispose() {
    _billedToController.dispose();
    _chalanNoController.dispose();
    _dateController.dispose();
    _invoiceStateCodeController.dispose();
    _invoiceStateNameController.dispose();
    _placeOfSupplyController.dispose();
    _vehicleNoController.dispose();
    _reverseChargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvoiceBloc, InvoiceState>(
      listener: (context, state) {
        if(state is SubmitInvoiceSuccessState){
          Navigator.pushReplacementNamed(context, "/products");
          return;
        }
        if(state is SubmitInvoiceFailedState){
          CustomSnackbar.snackbarShow(context, state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar().build(context),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<InvoiceDetailsBloc, InvoiceDetailsState>(
              builder: (context, state) {
                if (state is InvoiceDetailsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blue,
                      strokeCap: StrokeCap.round,
                    ),
                  );
                }
                if (state is InitialInvoiceDetailsFetchFailureState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.error),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          state.message,
                          style: GoogleFonts.poppins(
                            color: AppColors.black,
                            fontSize: 24,
                          ),
                        )
                      ],
                    ),
                  );
                }
                if (state is InitialInvoiceDetailsFetchSuccessState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StyledIcon(icon: Icons.receipt_long),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          maxLength: 46,
                          labelText: "Invoice Name",
                          controller: _invoiceNameController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          maxLength: 46,
                          labelText: "Invoice State",
                          controller: _invoiceStateNameController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          maxLength: 5,
                          labelText: "State Code",
                          controller: _invoiceStateCodeController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          maxLength: 46,
                          readOnly: true,
                          labelText: "Date of Supply",
                          controller: _dateController,
                          onTap: () {
                            _selectDate();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          maxLength: 46,
                          labelText: "Place of Supply",
                          controller: _placeOfSupplyController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          maxLength: 46,
                          labelText: "Vehicle no (Optional)",
                          controller: _vehicleNoController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          maxLength: 46,
                          labelText: "Chalan no (Optional)",
                          controller: _chalanNoController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment(-1, 0),
                          child: Text(
                            "Reverse Charge",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomDropDown(
                          list: ["Yes", "No"],
                          dropDownController: _reverseChargeController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment(-1, 0),
                          child: Text(
                            "Billed to",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomMapDropDown(
                          valueKey: "receiver_id",
                          labelKey: "receiver_name",
                          list: state.customers!,
                          dropDownController: _billedToController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment(-1, 0),
                          child: Text(
                            "Shipped by",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomMapDropDown(
                          labelKey: "consignee_name",
                          valueKey: "consignee_id",
                          list: state.shippers,
                          dropDownController: _shippedByController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<InvoiceBloc, InvoiceState>(
                          builder: (context, state) {
                            return CustomElevatedButton(
                              isLoading: state is SubmitInvoiceLoadingState,
                              buttonText: "Next",
                              onPressed: () {
                                context.read<InvoiceBloc>().add(
                                      SubmitInvoiceEvent(
                                        customerId: _billedToController.text,
                                        invoiceChallanNo:
                                            _chalanNoController.text ?? " ",
                                        invoiceDateOfSupply:
                                            _dateController.text,
                                        invoiceName:
                                            _invoiceNameController.text,
                                        invoicePlaceOfSupply:
                                            _placeOfSupplyController.text,
                                        invoiceReverseCharge:
                                            _reverseChargeController.text,
                                        invoiceState:
                                            _invoiceStateNameController.text,
                                        invoiceStateCode:
                                            _invoiceStateCodeController.text,
                                        invoiceVehicleNo:
                                            _vehicleNoController.text ?? " ",
                                        shipperId: _shippedByController.text,
                                      ),
                                    );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
