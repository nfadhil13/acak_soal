part of '../result_screen.dart';

class _DataUjian extends StatelessWidget {
  final int jumlahPeserta;
  final DataPengacakan dataPengacakan;
  const _DataUjian(
      {Key? key, required this.jumlahPeserta, required this.dataPengacakan})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      _BaseDataTable(title: "Data Ujian", data: {
        "Jumlah Peserta": "$jumlahPeserta Orang",
        "Jumlah Paket": "${dataPengacakan.jumlahPaket}",
        "Persentase Keunikan Acakan": "${dataPengacakan.persentaseKeunikan.toStringAsFixed(2)} %"
      });
}
