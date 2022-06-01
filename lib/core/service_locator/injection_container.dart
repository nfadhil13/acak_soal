import 'package:acak_soal/features/common/data/datasource/pengacakan_network_data_source.dart';
import 'package:acak_soal/features/common/data/repositories/pengacakan_repository_impl.dart';
import 'package:acak_soal/features/common/domain/repositories/pengacakan_repository.dart';
import 'package:acak_soal/features/form/presentation/choose_,layout/cubit/choose_layout_cubit.dart';
import 'package:acak_soal/features/form/presentation/form/cubit/form_cubit.dart';
import 'package:acak_soal/features/generate_template/data/datasource/generate_template_network_datasource.dart';
import 'package:acak_soal/features/generate_template/presentation/cubit/generate_template_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/generate_template/data/respositories/generate_template_repository_impl.dart';
import '../../features/generate_template/domain/repositories/generate_template_repository.dart';

final GetIt getIt = GetIt.instance;

class InjectionContainer {
  static Future<void> init() async {
    _injectCore();
    _injectDataSource();
    _injectRepository();
    _injectBloc();
  }
}

void _injectBloc() {
  getIt.registerFactory(() => FormCubit(getIt()));
  getIt.registerFactory(() => ChooselayoutcubitCubit(getIt()));
  getIt.registerFactory(() => GenerateTemplateCubit(getIt()));
}

void _injectRepository() {
  getIt.registerFactory<PengacakanRepository>(
      () => PengacakanRepositoryImpl(getIt()));
  getIt.registerFactory<GenerateTemplateRepository>(
      () => GenerateTemplateRepositoryImpl(getIt()));
}

void _injectDataSource() {
  getIt.registerFactory<PengacakanNetworkDataSource>(
      () => PengacakanNetworkDataSourceImpl(getIt()));
  getIt.registerFactory<GenereateTemplateNetworkDatasource>(
      () => GenerateTemplateNetworkDatasourceImpl(getIt()));
}

void _injectCore() {
  getIt.registerFactory(() => Dio());
}
