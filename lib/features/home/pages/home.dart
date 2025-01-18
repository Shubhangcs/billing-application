import 'package:flutter/material.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/features/home/widgets/services_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 360,
              ),
              ServicesCard(
                cardTitle: "Generate Invoice",
                leading: Icons.receipt_long_outlined,
                trailing: Icons.arrow_outward_rounded,
              ),
              SizedBox(height: 20,),
              ServicesCard(
                cardTitle: "Invoice History",
                leading: Icons.history,
                trailing: Icons.arrow_outward_rounded,
              ),
              SizedBox(height: 20,),
              ServicesCard(
                cardTitle: "Add New Customer",
                leading: Icons.group_add_sharp,
                trailing: Icons.arrow_outward_rounded,
              ),
              SizedBox(height: 20,),
              ServicesCard(
                cardTitle: "Add New Shipper",
                leading: Icons.person_3_rounded,
                trailing: Icons.arrow_outward_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
