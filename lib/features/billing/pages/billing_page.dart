import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/common/widgets/drop_down.dart';
import 'package:new_billing/core/common/widgets/text_field.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/features/authentication/widgets/styled_icon.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final TextEditingController _billedToController = TextEditingController();
  final TextEditingController _shippedByController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final List<Map<String, String>> _products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StyledIcon(icon: Icons.receipt_long),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Billed To",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomDropDown(
                  list: ["Hello", "hii"],
                  dropDownController: _billedToController,
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Shipped by",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomDropDown(
                  list: ["Hello", "hii"],
                  dropDownController: _shippedByController,
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Add Product",
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 320,
                      child: CustomDropDown(
                        list: ["Hello", "hii"],
                        dropDownController: _productController,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _products.add({"name": _productController.text});
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_products[index]["name"]!),
                      trailing: IconButton(icon: Icon(Icons.delete) , onPressed: (){
                        setState(() {
                          _products.remove(_products[index]);
                        });
                      },),
                    );
                  },
                  itemCount: _products.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
