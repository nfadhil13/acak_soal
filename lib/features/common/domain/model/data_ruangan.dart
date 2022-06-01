import 'package:acak_soal/features/common/domain/model/data_meja.dart';

class DataRuangan {
  final double panjangVertical;
  final double panjangHorizontal;
  final DataMeja dataMeja;

  DataRuangan(
      {required this.panjangVertical,
      required this.panjangHorizontal,
      required this.dataMeja});

  factory DataRuangan.init() => DataRuangan(
      panjangVertical: -1, panjangHorizontal: -1, dataMeja: DataMeja.init());

  DataRuangan copyWith(
      {double? panjangVertical,
      double? panjangHorizontal,
      DataMeja? dataMeja}) {
    return DataRuangan(
        dataMeja: dataMeja ?? this.dataMeja,
        panjangHorizontal: panjangHorizontal ?? this.panjangHorizontal,
        panjangVertical: panjangVertical ?? this.panjangVertical);
  }
}
