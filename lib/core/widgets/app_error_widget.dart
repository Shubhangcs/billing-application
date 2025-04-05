import 'package:flutter/material.dart';
import 'package:new_billing/core/themes/colors.dart';

class AppErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;
  const AppErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 40,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            errorMessage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "You Can Try Again",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(
            height: 5,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh_rounded,
              color: AppColors.blue,
            ),
          )
        ],
      ),
    );
  }
}
