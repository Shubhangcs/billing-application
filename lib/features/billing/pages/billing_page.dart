import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/common/widgets/drop_down.dart';
import 'package:new_billing/core/common/widgets/elevated_button.dart';
import 'package:new_billing/core/common/widgets/text_field.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/features/authentication/widgets/styled_icon.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  // Controllers for Fields
  final TextEditingController _invoiceStateNameController =
      TextEditingController();
  final TextEditingController _invoiceStateCodeController =
      TextEditingController();
  final TextEditingController _placeOfSupplyController =
      TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();
  final TextEditingController _chalanNoController = TextEditingController();
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
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StyledIcon(icon: Icons.receipt_long),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: "Invoice State",
                  controller: _invoiceStateNameController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: "State Code",
                  controller: _invoiceStateCodeController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
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
                  labelText: "Place of Supply",
                  controller: _placeOfSupplyController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: "Vehicle no (Optional)",
                  controller: _vehicleNoController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
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
                CustomDropDown(
                  list: ["Hello", "hii"],
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
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomDropDown(
                  list: ["Hello", "hii"],
                  dropDownController: _shippedByController,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomElevatedButton(
                  buttonText: "Next",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
