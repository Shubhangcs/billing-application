import 'package:flutter/material.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/core/widgets/app_filled_button.dart';

class DeleteBottomSheet extends StatelessWidget {
  final String invoiceId;
  final String invoiceName;
  final bool isLoading;
  final VoidCallback onDeletePressed;
  const DeleteBottomSheet({
    super.key,
    required this.invoiceId,
    required this.invoiceName,
    this.isLoading = false,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment(-1, 0),
            child: Text(
              "Delete",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    invoiceName,
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    invoiceId,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  leading: Icon(
                    Icons.insert_drive_file,
                    color: AppColors.blue,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AppFilledButton(
            isLoading: isLoading,
            onPressed: onDeletePressed,
            buttonText: "Delete",
            color: AppColors.red,
          ),
        ],
      ),
    );
  }
}
