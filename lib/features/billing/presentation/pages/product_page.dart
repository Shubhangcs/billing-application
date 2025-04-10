import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/common/widgets/custom_snackbar.dart';
import 'package:new_billing/core/common/widgets/drop_down.dart';
import 'package:new_billing/core/common/widgets/elevated_button.dart';
import 'package:new_billing/core/common/widgets/text_field.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/features/billing/presentation/bloc/products_bloc.dart';
import 'package:new_billing/features/pdf_viev/page/pdf_view_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    _fetchProducts();
    super.initState();
  }

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final TextEditingController _hsnSacController = TextEditingController();
  final TextEditingController _pricePerUnitController = TextEditingController();
  final TextEditingController _unitsController = TextEditingController();

  @override
  void dispose() {
    _productNameController.dispose();
    _pricePerUnitController.dispose();
    _productQuantityController.dispose();
    _hsnSacController.dispose();
    _unitsController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _productNameController.clear();
    _pricePerUnitController.clear();
    _productQuantityController.clear();
    _hsnSacController.clear();
  }

  Future<void> _gotoPdfPage() async {
    final box = await Hive.openBox("invoice");
    final id = box.get("invoice_id");
    box.close();
    _routeToPdfPage(id);
  }

  _routeToPdfPage(String id) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PDFScreen(
                pdfUrl: "http://apmc.api.vsensetech.in/download/invoice/$id")));
  }

  Future<void> _deleteProduct(String productId) async {
    final res = await delete(Uri.parse("https://apmc.api.vsensetech.in/delete/product/$productId"));
    if(res.statusCode == 200){
      _fetchProducts();
    }
  }

  _fetchProducts(){
    context.read<ProductsBloc>().add(
          FetchProductsEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is AddProductsSuccessState) {
          CustomSnackbar.snackbarShow(context, state.message);
          _clearFields();
          context.read<ProductsBloc>().add(FetchProductsEvent());
          return;
        }
        if (state is AddProductsFailedState) {
          CustomSnackbar.snackbarShow(context, state.message);
          return;
        }
      },
      child: Scaffold(
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
                  maxLength: 50,
                  labelText: "Product Name",
                  controller: _productNameController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  maxLength: 10,
                  labelText: "Product Quantity",
                  controller: _productQuantityController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomDropDown(
                  list: ["kg", "g", "pcs", "box", "ton", "bun", "mg"],
                  dropDownController: _unitsController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  maxLength: 10,
                  labelText: "HSN/SAC",
                  controller: _hsnSacController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  maxLength: 10,
                  labelText: "Price Per Unit",
                  controller: _pricePerUnitController,
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    return CustomElevatedButton(
                      isLoading: state is FetchProductLoadingState,
                      buttonText: "Add Product",
                      onPressed: () {
                        context.read<ProductsBloc>().add(
                              AddProductEvent(
                                productName: _productNameController.text,
                                productHsn: _hsnSacController.text,
                                productQty: _productQuantityController.text,
                                productRate: _pricePerUnitController.text,
                                productUnit: _unitsController.text,
                              ),
                            );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state is FetchProductSuccessState) {
                      if (state.products.isNotEmpty) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  _deleteProduct(state.products[index]["product_id"]); 
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              title:
                                  Text(state.products[index]["product_name"]),
                              subtitle: Text(
                                  "${state.products[index]["product_qty"]} ${state.products[index]["product_unit"]}"),
                              trailing: Text(
                                "₹${state.products[index]["total"]}",
                                style: GoogleFonts.poppins(
                                  color: AppColors.black,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                          itemCount: state.products.length,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(50),
                            child: Text(
                              "No Products Added.",
                            ),
                          ),
                        );
                      }
                    }
                    if (state is FetchProductsFailureState) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: Text(
                            state.message,
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: CircularProgressIndicator(
                          color: AppColors.blue,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    );
                  },
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
              _gotoPdfPage();
            },
          ),
        ),
      ),
    );
  }
}
