import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'invoice_details_event.dart';
part 'invoice_details_state.dart';

class InvoiceDetailsBloc extends Bloc<InvoiceDetailsEvent, InvoiceDetailsState> {
  InvoiceDetailsBloc() : super(InvoiceDetailsInitial()) {
    on<InvoiceDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
