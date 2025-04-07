import 'package:flutter/material.dart';
import 'package:new_billing/core/widgets/app_filled_button.dart';
import 'package:new_billing/core/widgets/app_text_field.dart';
import 'package:new_billing/core/widgets/app_text_field_multiline.dart';

class AddCustomerForm extends StatefulWidget {
  const AddCustomerForm({super.key});

  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Customer",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 15),
              AppTextField(
                controller: TextEditingController(),
                hintText: "Customer Name",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: TextEditingController(),
                      hintText: "State",
                      prefixIcon: Icons.location_on,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AppTextField(
                      controller: TextEditingController(),
                      hintText: "State Code",
                      prefixIcon: Icons.pin,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: TextEditingController(),
                      hintText: "Phone",
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AppTextField(
                      controller: TextEditingController(),
                      hintText: "GSTIN",
                      prefixIcon: Icons.password_rounded,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              AppTextFieldMultiline(
                controller: TextEditingController(),
                hintText: "Customer Address",
                keyboardType: TextInputType.text,
                maxLines: 3,
              ),
              const SizedBox(height: 15),
              AppFilledButton(
                onPressed: () {},
                buttonText: "Submit",
              )
            ],
          ),
        ),
      ),
    );
  }
}
