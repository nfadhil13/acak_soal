import 'dart:typed_data';

import 'package:acak_soal/features/common/domain/model/data_ruangan.dart';

class DataInputUjian {
  final DataRuangan dataRuangan;
  final int jumlahPeserta;

  DataInputUjian(this.dataRuangan, this.jumlahPeserta);

  factory DataInputUjian.init() => DataInputUjian(DataRuangan.init(), -1);

  DataInputUjian copyWith({DataRuangan? dataRuangan, int? jumlahPeserta}) =>
      DataInputUjian(
          dataRuangan ?? this.dataRuangan, jumlahPeserta ?? this.jumlahPeserta);
}
