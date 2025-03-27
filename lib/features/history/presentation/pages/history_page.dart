import 'package:flutter/material.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/core/widgets/app_filled_button.dart';
import 'package:new_billing/features/history/presentation/widgets/history_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  void _showBottomSheet(
    BuildContext context,
    bool isDone,
    String name,
    String id,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment(-1, 0),
                child: Text(
                  "Invoice",
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
                        name,
                        style: Theme.of(context).textTheme.labelLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        id,
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
                onPressed: isDone ? null : () {},
                buttonText: "Mark as Done",
              ),
              SizedBox(
                height: 10,
              ),
              AppFilledButton(
                onPressed: () {},
                buttonText: "View Invoice",
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh_rounded,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment(-1, 0),
                child: Text(
                  "Invoice History",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment(-1, 0),
                child: Text(
                  "List of the Invoices Generated.",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return HistoryTile(
                    onPressed: () {
                      _showBottomSheet(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                        context,
                        true,
                        "Shubhanga CS",
                        "4drps-gsyy7b-nksm-2jsk-sadas",
                      );
                    },
                  );
                },
                itemCount: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
