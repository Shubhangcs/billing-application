import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_firm_state.dart';

class FetchFirmCubit extends Cubit<FetchFirmState> {
  FetchFirmCubit() : super(FetchFirmInitial());
}
