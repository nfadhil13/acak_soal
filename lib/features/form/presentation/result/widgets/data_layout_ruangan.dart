part of '../result_screen.dart';

class _DataLayoutRuagan extends StatelessWidget {
  final LayoutRuangan layoutRuangan;
  const _DataLayoutRuagan({Key? key, required this.layoutRuangan}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      _BaseDataTable(title: "Data Layout Ruangan", data: {
        "Jarak Antar Baris": "${layoutRuangan.jarakAntarBaris} cm",
        "Jarak Antar Kolom": "${layoutRuangan.jarakAntarKolom} cm",
        "Jumlah Baris": "${layoutRuangan.jumlahMejaBaris} Baris",
        "Jumlah Kolom": "${layoutRuangan.jumlahMejaKolom} Kolom",
        "Kapasitas Maksimum" : "${layoutRuangan.kapasitasPeserta} Orang"
      });
}


