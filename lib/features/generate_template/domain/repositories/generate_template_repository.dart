import '../../../../core/util/resource.dart';

abstract class GenerateTemplateRepository {
  Future<Resource<bool>> generateTemplate(
      {required String email, required int numberOfSoal});
}
