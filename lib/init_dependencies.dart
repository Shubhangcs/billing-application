import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:new_billing/core/utils/connection/connection.dart';
import 'package:new_billing/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:new_billing/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:new_billing/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:new_billing/features/authentication/domain/repository/auth_repository.dart';
import 'package:new_billing/features/authentication/domain/usecases/login_usecase.dart';
import 'package:new_billing/features/authentication/domain/usecases/register_usecase.dart';
import 'package:new_billing/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

part 'init_dependencies.main.dart';