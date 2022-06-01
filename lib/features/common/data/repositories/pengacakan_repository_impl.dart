import 'package:acak_soal/core/util/base_repo.dart';
import 'package:acak_soal/features/common/data/datasource/pengacakan_network_data_source.dart';
import 'package:acak_soal/features/common/domain/model/data_input_ujian.dart';
import 'package:acak_soal/features/common/domain/model/data_ujian_final.dart';
import 'package:acak_soal/features/common/domain/model/layout_ruangan.dart';
import 'package:acak_soal/features/common/domain/model/data_ruangan.dart';
import 'package:acak_soal/core/util/resource.dart';
import 'dart:typed_data';

import 'package:acak_soal/features/common/domain/repositories/pengacakan_repository.dart';

class PengacakanRepositoryImpl extends BaseRepository
    implements PengacakanRepository {
  final PengacakanNetworkDataSource _pengacakanNetworkDataSource;

  PengacakanRepositoryImpl(this._pengacakanNetworkDataSource);

  @override
  Future<Resource<List<LayoutRuangan>>> getOptimumLayoutRuangan(
          {required DataInputUjian dataInputUjian,
          required Uint8List dataSoal}) =>
      networkOnlyCall(networkCall: () async {
        return Resource.success(
            data: await _pengacakanNetworkDataSource.getLayoutRuangan(
                dataUjian: dataInputUjian, dataSoal: dataSoal));
      });

  @override
  Future<Resource<DataUjianFinal>> startAcak(
          {required DataInputUjian dataInputUjian,
          required Uint8List dataSoal,
          required LayoutRuangan layoutRuangan}) =>
      networkOnlyCall(networkCall: () async {
        return Resource.success(
            data: await _pengacakanNetworkDataSource.startAcak(
                dataInputUjian: dataInputUjian,
                dataSoal: dataSoal,
                layoutRuangan: layoutRuangan));
      });

  @override
  Future<Resource<bool>> sentEmail(
          {required String email,
          required String soalPath,
          required Uint8List pdf}) =>
      networkOnlyCall(networkCall: () async {
        await _pengacakanNetworkDataSource.sendResultEmail(
            email: email, soalPath: soalPath, pdf: pdf);
        return Resource.success(data: true);
      });
}
