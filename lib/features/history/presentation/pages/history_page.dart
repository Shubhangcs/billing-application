import 'package:flutter/material.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/features/history/presentation/widgets/history_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment(-1, 0),
                child: Text(
                  "List of the Invoices Generated.",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return HistoryTile();
                },
                itemCount: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
