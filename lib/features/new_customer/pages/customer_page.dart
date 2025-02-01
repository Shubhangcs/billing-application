import "package:flutter/material.dart";
import "package:new_billing/core/common/widgets/app_bar.dart";
import "package:new_billing/core/common/widgets/elevated_button.dart";
import "package:new_billing/core/common/widgets/text_field.dart";

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Customer Name",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Customer Address",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Customer GSTIN",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Customer Phone Number",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Customer State",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Customer State Code",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              buttonText: "Add Customer",
              onPressed: () {
                // TODO: Button Action is to be Added
              },
            ),
          ],
        ),
      ),
    );
  }
}
