import 'package:flutter/material.dart';
import 'package:new_billing/core/themes/colors.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: AppColors.opacBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 50,
          height: 50,
          child: Center(
            child: Icon(
              Icons.history_rounded,
              color: AppColors.blue,
            ),
          ),
        ),
        title: Text(
          "Title",
          style: Theme.of(context).textTheme.titleSmall,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          "Subtitle",
          style: Theme.of(context).textTheme.labelSmall,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
