import 'package:dartz/dartz.dart';
import 'package:new_billing/core/failures/failure.dart';
import 'package:new_billing/features/history/domain/entities/history_entity.dart';

abstract interface class HistoryRepository {
  Future<Either<Failure,List<HistoryEntity>>> getInvoices();
}