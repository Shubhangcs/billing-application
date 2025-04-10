import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_billing/core/widgets/app_filled_button.dart';
import 'package:new_billing/core/widgets/app_text_field.dart';
import 'package:new_billing/core/widgets/app_text_field_multiline.dart';

class AddFirmForm extends StatefulWidget {
  const AddFirmForm({super.key});

  @override
  State<AddFirmForm> createState() => _AddFirmFormState();
}

class _AddFirmFormState extends State<AddFirmForm> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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
                "Firm",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
                child: Center(
                  child: Container(
                    child: _image == null
                        ? Image.asset(
                            "assets/image.png",
                            width: 100,
                          )
                        : Image.file(
                            _image!,
                            width: 100,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              AppTextField(
                controller: TextEditingController(),
                hintText: "Firm Name",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: TextEditingController(),
                      hintText: "PAN",
                      prefixIcon: Icons.password_rounded,
                      keyboardType: TextInputType.text,
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
              AppTextField(
                controller: TextEditingController(),
                hintText: "Firm Phone",
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              AppTextField(
                controller: TextEditingController(),
                hintText: "Firm Email",
                prefixIcon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 15),
              AppTextFieldMultiline(
                controller: TextEditingController(),
                hintText: "Firm Address",
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
