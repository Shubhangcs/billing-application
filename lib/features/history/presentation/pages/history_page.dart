import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_billing/core/themes/colors.dart';
import 'package:new_billing/core/widgets/app_delete_confirmation_bottom_sheet.dart';
import 'package:new_billing/core/widgets/app_error_widget.dart';
import 'package:new_billing/core/widgets/app_snack_bar.dart';
import 'package:new_billing/features/history/presentation/bloc/history_bloc.dart';
import 'package:new_billing/features/history/presentation/cubit/delete_invoice_cubit.dart';
import 'package:new_billing/features/history/presentation/cubit/payment_status_updater_cubit.dart';
import 'package:new_billing/features/history/presentation/widgets/history_loading_widget.dart';
import 'package:new_billing/features/history/presentation/widgets/history_tile.dart';
import 'package:new_billing/features/history/presentation/widgets/update_payment_bottom_sheet.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    BlocProvider.of<HistoryBloc>(context).add(
      FetchInvoiceHistoryEvent(),
    );
    super.initState();
  }

  void _showDeleteConfirmationDialog({
    required BuildContext context,
    required String invoiceName,
    required String invoiceId,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocBuilder<DeleteInvoiceCubit, DeleteInvoiceState>(
            builder: (context, state) {
              return AppDeleteConfirmationBottomSheet(
                isLoading: state is DeleteInvoiceLoadingState,
                onDeletePressed: () {
                  BlocProvider.of<DeleteInvoiceCubit>(context).deleteInvoice(
                    invoiceId: invoiceId,
                  );
                },
                title: invoiceId,
                subtitle: invoiceName,
              );
            },
          );
        });
  }

  void _showUpdatePaymentDialog({
    required BuildContext context,
    required String invoiceId,
    required String invoiceName,
    required bool isPaid,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocBuilder<PaymentStatusUpdaterCubit,
            PaymentStatusUpdaterState>(
          builder: (context, state) {
            return UpdatePaymentBottomSheet(
              isLoading: state is PaymentStatusUpdateLoadingState,
              onPaymentDone: () {
                BlocProvider.of<PaymentStatusUpdaterCubit>(context)
                    .updatePaymentStatus(
                  invoiceId: invoiceId,
                );
              },
              invoiceId: invoiceId,
              invoiceName: invoiceName,
              isPaid: isPaid,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteInvoiceCubit, DeleteInvoiceState>(
          listener: (context, state) {
            if (state is DeleteInvoiceFailureState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.message).build(context),
              );
            }
            if (state is DeleteInvoiceSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.message).build(context),
              );
              BlocProvider.of<HistoryBloc>(context).add(
                FetchInvoiceHistoryEvent(),
              );
            }
          },
        ),
        BlocListener<PaymentStatusUpdaterCubit, PaymentStatusUpdaterState>(
          listener: (context, state) {
            if (state is PaymentStatusUpdateFailureState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.message).build(context),
              );
            }
            if (state is PaymentStatusUpdateSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackBar(message: state.message).build(context),
              );
              BlocProvider.of<HistoryBloc>(context).add(
                FetchInvoiceHistoryEvent(),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("History"),
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<HistoryBloc>(context).add(
                  FetchInvoiceHistoryEvent(),
                );
              },
              icon: Icon(
                Icons.refresh_rounded,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is FetchInvoicesLoadingState) {
              return HistoryLoadingWidget();
            }
            if (state is FetchInvoiceHistoryFailedState) {
              return AppErrorWidget(
                errorMessage: state.message,
                onPressed: () {
                  BlocProvider.of<HistoryBloc>(context).add(
                    FetchInvoiceHistoryEvent(),
                  );
                },
              );
            }
            if (state is FetchInvoiceHistorySuccessState) {
              return SingleChildScrollView(
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
                            invoiceName: state.invoices[index].invoiceName,
                            invoiceId: state.invoices[index].invoiceId,
                            onDeletePressed: () {
                              _showDeleteConfirmationDialog(
                                context: context,
                                invoiceId: state.invoices[index].invoiceId,
                                invoiceName: state.invoices[index].invoiceName,
                              );
                            },
                            onTilePressed: () {
                              _showUpdatePaymentDialog(
                                context: context,
                                invoiceId: state.invoices[index].invoiceId,
                                invoiceName: state.invoices[index].invoiceName,
                                isPaid: state.invoices[index].paymentStatus,
                              );
                            },
                          );
                        },
                        itemCount: state.invoices.length,
                      )
                    ],
                  ),
                ),
              );
            }
            return HistoryLoadingWidget();
          },
        ),
      ),
    );
  }
}
