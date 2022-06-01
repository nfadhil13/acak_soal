part of '../result_screen.dart';

class _DataRuangan extends StatelessWidget {
  final DataRuangan dataRuangan;
  const _DataRuangan({Key? key, required this.dataRuangan}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      _BaseDataTable(title: "Data Ruangan", data: {
        "Panjang Horizontal": "${dataRuangan.panjangHorizontal / 100} Meter",
        "Panjang Vertical": "${dataRuangan.panjangVertical / 100} Meter",
      });
}
