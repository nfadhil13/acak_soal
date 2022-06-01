import 'package:acak_soal/features/common/domain/model/layout_ruangan.dart';

class LayoutRuanganModel extends LayoutRuangan {
  LayoutRuanganModel(
      {required super.jarakAntarBaris,
      required super.jarakAntarKolom,
      required super.kapasitasPeserta,
      required super.jumlahMejaBaris,
      required super.jumlahMejaKolom});

  factory LayoutRuanganModel.fromJson(Map<String, dynamic> json) =>
      LayoutRuanganModel(
          jarakAntarBaris: json["jb"],
          jarakAntarKolom: json["jk"],
          jumlahMejaBaris: json["jumlahVertical"],
          jumlahMejaKolom: json["horizontal"],
          kapasitasPeserta: json["total"]);

  factory LayoutRuanganModel.fromSuperClass(LayoutRuangan layoutRuangan) =>
      LayoutRuanganModel(
          jarakAntarBaris: layoutRuangan.jarakAntarBaris,
          jarakAntarKolom: layoutRuangan.jarakAntarKolom,
          kapasitasPeserta: layoutRuangan.kapasitasPeserta,
          jumlahMejaBaris: layoutRuangan.jumlahMejaBaris,
          jumlahMejaKolom: layoutRuangan.jumlahMejaKolom);

  Map<String, dynamic> toJson() => {
        "jarakBaris": jarakAntarBaris,
        "jarakKolom": jarakAntarKolom,
        "panjangBaris": jumlahMejaBaris,
        "panjangKolom": jumlahMejaKolom
      };
}
