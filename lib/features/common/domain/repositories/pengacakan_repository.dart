import 'dart:typed_data';

import 'package:acak_soal/features/common/domain/model/data_input_ujian.dart';
import 'package:acak_soal/features/common/domain/model/data_ujian_final.dart';
import 'package:acak_soal/features/common/domain/model/layout_ruangan.dart';

import '../../../../core/util/resource.dart';

abstract class PengacakanRepository {
  Future<Resource<List<LayoutRuangan>>> getOptimumLayoutRuangan(
      {required DataInputUjian dataInputUjian, required Uint8List dataSoal});

  Future<Resource<DataUjianFinal>> startAcak(
      {required DataInputUjian dataInputUjian, required Uint8List dataSoal, required LayoutRuangan layoutRuangan});
}
