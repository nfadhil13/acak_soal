part of '../result_screen.dart';

class _DataMeja extends StatelessWidget {
  final DataMeja dataMeja;
  const _DataMeja({Key? key, required this.dataMeja}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      _BaseDataTable(title: "Data Meja", data: {
        "Panjang Meja": "${dataMeja.panjang} cm",
        "Lebar Meja": "${dataMeja.lebar} cm",
      });
}
