import 'dart:convert';
import 'dart:typed_data';

import 'package:acak_soal/core/const/network_const.dart';
import 'package:acak_soal/features/common/data/model/data_ujian_final_model.dart';
import 'package:acak_soal/features/common/data/model/input_ruangan.dart';
import 'package:acak_soal/features/common/data/model/layout_ruangan_model.dart';
import 'package:acak_soal/features/common/domain/model/data_input_ujian.dart';
import 'package:acak_soal/features/common/domain/model/data_ujian_final.dart';
import 'package:acak_soal/features/common/domain/model/layout_ruangan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';

import '../../domain/model/data_ruangan.dart';

abstract class PengacakanNetworkDataSource {
  Future<List<LayoutRuangan>> getLayoutRuangan(
      {required DataInputUjian dataUjian, required Uint8List dataSoal});

  Future<DataUjianFinal> startAcak(
      {required DataInputUjian dataInputUjian,
      required Uint8List dataSoal,
      required LayoutRuangan layoutRuangan});

  Future<void> sendResultEmail(
      {required String email,
      required String soalPath,
      required Uint8List pdf});
}

class PengacakanNetworkDataSourceTestImpl
    implements PengacakanNetworkDataSource {
        final Dio _dio;

  PengacakanNetworkDataSourceTestImpl(this._dio);
  @override
  Future<List<LayoutRuangan>> getLayoutRuangan(
      {required DataInputUjian dataUjian, required Uint8List dataSoal}) async {
    return [];
  }

  @override
  Future<DataUjianFinal> startAcak(
      {required DataInputUjian dataInputUjian,
      required Uint8List dataSoal,
      required LayoutRuangan layoutRuangan}) async {
    final jsonText =
        await rootBundle.loadString('assets/test/data_ujian_final.json');
    final data = json.decode(jsonText);
    final result = (data as Map<String, dynamic>)["data"];
    return DataUjianFinalModel.fromJSONKetetanggan(
        filePath: result["zipFilePath"],
        dataRuangan: dataInputUjian.dataRuangan,
        jsonKetetanggan: (result["processResult"]["hasilGraph"]["graph"]),
        jumlahPeserta: dataInputUjian.jumlahPeserta,
        layoutRuangan: layoutRuangan,
        paketURL: result["zipUrl"],
        persentaseKeunikan: result["processResult"]["hasilAcakan"]
            ["persentaseKeunikan"],
        jumlahPaket: result["processResult"]["hasilGraph"]["chromaticNumber"]);
  }

  @override
  Future<void> sendResultEmail(
      {required String email,
      required String soalPath,
      required Uint8List pdf}) async{
    final formData = FormData.fromMap({
      "zipFilePath": soalPath,
      "email": email,
      "dashboardPdf": MultipartFile.fromBytes(pdf,
          filename: "soal.json", contentType: MediaType("application", "pdf"))
    });
    await _dio.post("${NetworkConst.baseUrl}/main-process/send-result",
        data: formData);
  }
}

class PengacakanNetworkDataSourceImpl implements PengacakanNetworkDataSource {
  final Dio _dio;

  PengacakanNetworkDataSourceImpl(this._dio);
  @override
  Future<List<LayoutRuangan>> getLayoutRuangan(
      {required DataInputUjian dataUjian, required Uint8List dataSoal}) async {
    final response = await _dio.post("${NetworkConst.baseUrl}/optimasi-ruangan",
        data: InputRuangan.fromDomain(dataUjian, dataSoal).toMapWithoutFile());
    final result = ((response.data as Map<String, dynamic>)["data"]
            ["OpsiLayoutKelas"] as List)
        .map((e) => LayoutRuanganModel.fromJson(e))
        .toList();
    result.sort((a, b) => a.kapasitasPeserta.compareTo(b.kapasitasPeserta));
    return result;
  }

  @override
  Future<DataUjianFinal> startAcak(
      {required DataInputUjian dataInputUjian,
      required Uint8List dataSoal,
      required LayoutRuangan layoutRuangan}) async {
    final formData = FormData.fromMap({
      ...InputRuangan.fromDomain(dataInputUjian, dataSoal).toMap(),
      ...LayoutRuanganModel.fromSuperClass(layoutRuangan).toJson()
    });
    final response = await _dio
        .post("${NetworkConst.baseUrl}/main-process/process", data: formData);
    final result = (response.data as Map<String, dynamic>)["data"];
    return DataUjianFinalModel.fromJSONKetetanggan(
        filePath: result["zipFilePath"],
        dataRuangan: dataInputUjian.dataRuangan,
        jsonKetetanggan: (result["processResult"]["hasilGraph"]["graph"]),
        jumlahPeserta: dataInputUjian.jumlahPeserta,
        layoutRuangan: layoutRuangan,
        paketURL: result["zipUrl"],
        persentaseKeunikan: result["processResult"]["hasilAcakan"]
            ["persentaseKeunikan"],
        jumlahPaket: result["processResult"]["hasilGraph"]["chromaticNumber"]);
  }

  @override
  Future<void> sendResultEmail(
      {required String email,
      required String soalPath,
      required Uint8List pdf}) async {
    final formData = FormData.fromMap({
      "zipFilePath": soalPath,
      "email": email,
      "dashboardPdf": MultipartFile.fromBytes(pdf,
          filename: "soal.json", contentType: MediaType("application", "pdf"))
    });
    await _dio.post("${NetworkConst.baseUrl}/main-process/send-result",
        data: formData);
  }
}
