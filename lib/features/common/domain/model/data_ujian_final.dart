import 'package:acak_soal/features/common/domain/model/data_ketetanggaan.dart';
import 'package:acak_soal/features/common/domain/model/data_pengacakan.dart';
import 'package:acak_soal/features/common/domain/model/data_ruangan.dart';
import 'package:acak_soal/features/common/domain/model/layout_ruangan.dart';

class DataUjianFinal {
  final DataRuangan dataRuangan;
  final int jumlahPeserta;
  final LayoutRuangan layoutRuangan;
  final List<DataKetetanggaan> listKetetanggaan;
  final DataPengacakan dataPengacakan;
  DataUjianFinal(
      this.dataRuangan,
      this.layoutRuangan,
      this.listKetetanggaan,
      this.jumlahPeserta,
      this.dataPengacakan);
}
