import 'package:acak_soal/features/common/domain/model/data_ketetanggaan.dart';

class DataKetetanggaanModel extends DataKetetanggaan {
  DataKetetanggaanModel(super.adjacentList, super.nomorPaket);

  factory DataKetetanggaanModel.fromJson(Map<String, dynamic> json) {
    final listDynamicTetangga = (json["adjacents"] as List);
    final listTetangga = <int>[];
    for (var value in listDynamicTetangga) {
      if (listDynamicTetangga is int) {
        listTetangga.add(value);
      } else {
        final parsedValue = int.tryParse(value.toString());
        if (parsedValue != null) listTetangga.add(value);
      }
    }
    return DataKetetanggaanModel(listTetangga, json["paket"]);
  }
}
