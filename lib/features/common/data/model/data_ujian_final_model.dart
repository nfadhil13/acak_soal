import 'dart:convert';

import 'package:acak_soal/features/common/domain/model/data_pengacakan.dart';
import 'package:acak_soal/features/common/domain/model/data_ujian_final.dart';

import '../../domain/model/data_ruangan.dart';
import '../../domain/model/layout_ruangan.dart';
import 'data_ketetanggaan_model.dart';

class DataUjianFinalModel extends DataUjianFinal {
  DataUjianFinalModel(super.dataRuangan, super.layoutRuangan,
      super.listKetetanggaan, super.jumlahPeserta, super.dataPengacakan);

  factory DataUjianFinalModel.fromJSONKetetanggan(
          {required DataRuangan dataRuangan,
          required int jumlahPeserta,
          required LayoutRuangan layoutRuangan,
          required List<dynamic> jsonKetetanggan,
          required String paketURL,
          required int jumlahPaket,
          required double persentaseKeunikan}) =>
      DataUjianFinalModel(
          dataRuangan,
          layoutRuangan,
          jsonKetetanggan
              .map((e) => DataKetetanggaanModel.fromJson((e as List)[1]))
              .toList(),
          jumlahPeserta,
          DataPengacakan(jumlahPaket, paketURL, persentaseKeunikan));
}
