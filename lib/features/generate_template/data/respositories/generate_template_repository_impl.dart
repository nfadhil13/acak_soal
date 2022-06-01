import 'package:acak_soal/core/util/base_repo.dart';
import 'package:acak_soal/core/util/resource.dart';
import 'package:acak_soal/features/generate_template/data/datasource/generate_template_network_datasource.dart';
import 'package:acak_soal/features/generate_template/domain/repositories/generate_template_repository.dart';

class GenerateTemplateRepositoryImpl extends BaseRepository
    implements GenerateTemplateRepository {
  final GenereateTemplateNetworkDatasource _datasource;

  GenerateTemplateRepositoryImpl(this._datasource);
  @override
  Future<Resource<bool>> generateTemplate(
          {required String email, required int numberOfSoal}) =>
      networkOnlyCall(networkCall: () async {
        await _datasource.generateTemplate(
            email: email, numberOfSoal: numberOfSoal);
        return Resource.success(data: true);
      });
}
