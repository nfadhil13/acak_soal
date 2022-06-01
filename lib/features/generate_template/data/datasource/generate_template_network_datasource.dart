import 'package:acak_soal/core/const/network_const.dart';
import 'package:dio/dio.dart';

abstract class GenereateTemplateNetworkDatasource {
  Future<void> generateTemplate(
      {required String email, required int numberOfSoal});
}

class GenerateTemplateNetworkDatasourceImpl
    implements GenereateTemplateNetworkDatasource {
  final Dio _dio;

  GenerateTemplateNetworkDatasourceImpl(this._dio);
  @override
  Future<void> generateTemplate(
      {required String email, required int numberOfSoal}) async {
    await _dio.post("${NetworkConst.baseUrl}/generate-template",
        data: {"jumlahSoal": numberOfSoal, "email": email});
  }
}
