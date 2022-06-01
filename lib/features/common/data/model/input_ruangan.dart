import 'dart:typed_data';

import 'package:acak_soal/features/common/domain/model/data_input_ujian.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class InputRuangan {
  final double panjangHorizontal;
  final double panjangVertical;
  final double panjangMeja;
  final double lebarMeja;
  final int jumlahPeserta;
  final Uint8List file;

  InputRuangan(this.panjangHorizontal, this.panjangVertical, this.panjangMeja,
      this.lebarMeja, this.jumlahPeserta, this.file);

  factory InputRuangan.fromDomain(DataInputUjian dataRuangan, Uint8List soal) =>
      InputRuangan(
          dataRuangan.dataRuangan.panjangHorizontal,
          dataRuangan.dataRuangan.panjangVertical,
          dataRuangan.dataRuangan.dataMeja.panjang,
          dataRuangan.dataRuangan.dataMeja.lebar,
          dataRuangan.jumlahPeserta,
          soal);

  Map<String, dynamic> toMap() {
    return {
      "horizontalRuangan": panjangHorizontal,
      "vertikalRuangan": panjangVertical,
      "horizontalMeja": panjangMeja,
      "vertikalMeja": lebarMeja,
      "jumlahPeserta": jumlahPeserta,
      "listSoal": MultipartFile.fromBytes(file, filename: "soal.json", contentType: MediaType("application", "json"))
    };
  }
}
