import 'package:flutter/material.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/common/widgets/elevated_button.dart';
import 'package:new_billing/core/common/widgets/text_field.dart';

class ShipperPage extends StatefulWidget {
  const ShipperPage({super.key});

  @override
  State<ShipperPage> createState() => _ShipperPageState();
}

class _ShipperPageState extends State<ShipperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Shipper Name",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Shipper Address",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Shipper GSTIN",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Shipper Phone Number",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Shipper State",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: "Shipper State Code",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              buttonText: "Add Shipper",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
