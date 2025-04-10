import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_firm_state.dart';

class DeleteFirmCubit extends Cubit<DeleteFirmState> {
  DeleteFirmCubit() : super(DeleteFirmInitial());
}
