import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_billing/features/firm/domain/usecases/add_firm_usecase.dart';

part 'add_firm_state.dart';

class AddFirmCubit extends Cubit<AddFirmState> {
  final AddFirmUsecase _addFirmUsecase;
  AddFirmCubit({required AddFirmUsecase addFirmUsecase})
      : _addFirmUsecase = addFirmUsecase,
        super(AddFirmInitial());
  Future<void> addFirm({
    required String firmName,
    required String firmAddress,
    required String firmGstNumber,
    required String firmPhoneNumber,
    required String firmEmail,
    required String firmPan,
    required String firmLogo,
  }) async {
    emit(AddFirmLoadingState());
    final response = await _addFirmUsecase(
      AddFirmParams(
        firmAddress: firmAddress,
        firmGstNumber: firmGstNumber,
        firmName: firmName,
        firmPhoneNumber: firmPhoneNumber,
        firmEmail: firmEmail,
        firmPan: firmPan,
        firmLogo: File(firmLogo),
      ),
    );
    response.fold(
      (failure) {
        emit(
          AddFirmFailureState(
            message: failure.message,
          ),
        );
      },
      (success) {
        emit(
          AddFirmSuccessState(
            message: success,
          ),
        );
      },
    );
  }
}
