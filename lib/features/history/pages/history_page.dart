import 'package:flutter/material.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.receipt),
              title: Text("Invoice id"),
              subtitle: Text("Invoice number"),
              trailing: IconButton(
                icon: Icon(Icons.payment),
                onPressed: () { },
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
