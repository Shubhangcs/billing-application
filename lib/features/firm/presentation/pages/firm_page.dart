import 'package:flutter/material.dart';
import 'package:new_billing/core/widgets/app_delete_confirmation_bottom_sheet.dart';
import 'package:new_billing/features/firm/presentation/widgets/add_firm_form.dart';
import 'package:new_billing/features/firm/presentation/widgets/firm_tile.dart';

class FirmPage extends StatefulWidget {
  const FirmPage({super.key});

  @override
  State<FirmPage> createState() => _FirmPageState();
}

class _FirmPageState extends State<FirmPage> {
  void _showAddFirmBottomsheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AddFirmForm(),
    );
  }

  void _showDeleteBottomsheet({
    required String firmName,
    required String firmAddress,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => AppDeleteConfirmationBottomSheet(
        title: firmName,
        subtitle: firmAddress,
        onDeletePressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firms"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Firm's",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Already Exesting Firm's",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return FirmTile(
                    firmEmail: "developer.shubhangcs@gmail.com",
                    firmPanNumber: "SHJJA76378",
                    firmName: "Prajwal Andanur",
                    firmPhoneNumber: "8618245446",
                    onDeletePressed: () {
                      _showDeleteBottomsheet(
                        firmName: "Prajwal Andanur",
                        firmAddress: "Shobhavana Campus, Mijar.",
                      );
                    },
                    firmAddress: "Shobhavana Campus, Mijar.",
                    firmGstNumber: "3721678ewjedhwjq",
                    firmState: "Karnataka",
                  );
                },
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFirmBottomsheet();
        },
        child: Icon(
          Icons.add_rounded,
        ),
      ),
    );
  }
}
