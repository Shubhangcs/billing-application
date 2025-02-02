import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_billing/core/common/widgets/app_bar.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/features/history/bloc/history_bloc.dart';
import 'package:new_billing/features/pdf_viev/page/pdf_view_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(
          FetchInvoiceHistoryEvent(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().build(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is FetchInvoiceHistorySuccessState) {
              if (state.invoices != null) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PDFScreen(pdfUrl: "http://apmc.api.vsensetech.in/download/invoice/${state.invoices![index]["invoice_id"]}")));
                      },
                      leading: Icon(Icons.receipt),
                      title: Text(state.invoices![index]["name"]),
                      subtitle: Text(state.invoices![index]["invoice_id"]),
                      trailing: IconButton(
                        icon: state.invoices![index]["payment_status"]
                            ? Icon(
                                Icons.done,
                                color: Colors.green,
                              )
                            : Icon(Icons.payment),
                        onPressed: () {},
                      ),
                    );
                  },
                  itemCount: state.invoices!.length,
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.not_interested_rounded,
                        size: 30,
                      ),
                      Text(
                        "No Invoices to Display...",
                        style: GoogleFonts.poppins(
                          color: AppColors.black,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            if (state is FetchInvoiceHistoryFailedState) {
              return Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.not_interested_rounded,
                      size: 30,
                    ),
                    Text(
                      state.message,
                      style: GoogleFonts.poppins(
                        color: AppColors.black,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.blue,
                strokeCap: StrokeCap.round,
              ),
            );
          },
        ),
      ),
    );
  }
}
