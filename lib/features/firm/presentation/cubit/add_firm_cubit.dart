import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_firm_state.dart';

class AddFirmCubit extends Cubit<AddFirmState> {
  AddFirmCubit() : super(AddFirmInitial());
}
