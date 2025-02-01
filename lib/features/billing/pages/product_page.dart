import 'package:flutter/material.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/common/widgets/elevated_button.dart';
import 'package:new_billing/core/common/widgets/text_field.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productQuantityController = TextEditingController();
  final TextEditingController _hsnSacController = TextEditingController();
  final TextEditingController _pricePerUnitController = TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    _pricePerUnitController.dispose();
    _productQuantityController.dispose();
    _hsnSacController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: "Product Name",
                controller: _productNameController,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: "Product Quantity",
                controller: _productQuantityController,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: "HSN/SAC",
                controller: _hsnSacController,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                labelText: "Price Per Unit",
                controller: _pricePerUnitController,
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                buttonText: "Add Product",
                onPressed: () {
                  
                },
              ),
              SizedBox(
                height: 30,
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.shopping_bag_sharp),
                    title: Text("Item Name"),
                    subtitle: Text("Item Quantity and Price"),
                    trailing: Icon(Icons.delete),
                  );
                },
                itemCount: 5,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomElevatedButton(
          buttonText: "Generate Invoice",
          onPressed: () {
            // TODO: Generate Invoice
          },
        ),
      ),
    );
  }
}
