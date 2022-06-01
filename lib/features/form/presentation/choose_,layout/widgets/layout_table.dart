part of '../choose_layout_screen.dart';

class _LayoutTable extends StatelessWidget {
  final ChooseLayoutArgs chooseLayoutArgs;
  const _LayoutTable({Key? key, required this.chooseLayoutArgs})
      : super(key: key);

  void showDialog(BuildContext context, LayoutRuangan layoutRuangan) {
    EasyDialog(
        title: const Text(""),
        description: const Text(""),
        height: 200,
        contentList: [
          Text(
            "Konfirmasi Layout Kelas",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: ColorTheme.primaryColor),
            textScaleFactor: 1.2,
          ),
          const SizedBox(height: 10),
          const Text(
            """Apakah anda yakin memilih layout kelas ini ?""",
            textScaleFactor: 1.1,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context
                      .read<ChooselayoutcubitCubit>()
                      .startAcakSoal(chooseLayoutArgs, layoutRuangan);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Accept",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: ColorTheme.primaryColor),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cancel",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: ColorTheme.primaryColor),
                  ),
                ),
              ),
            ],
          )
        ]).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final columnTextStyle = TextStyle(
        color: ColorTheme.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 16);

    final cellTextStyle = columnTextStyle.copyWith(
        fontWeight: FontWeight.normal, color: Colors.black);
    return DataTable(
        columns: [
          DataColumn(
              label: Text(
            "No",
            style: columnTextStyle,
          )),
          DataColumn(
              label: Text(
            "Jumlah Baris Peserta",
            style: columnTextStyle,
          )),
          DataColumn(
              label: Text(
            "Jumlah Kolom Peserta",
            style: columnTextStyle,
          )),
          DataColumn(
              label: Text(
            "Kapasitas Maksimum Ruangan",
            style: columnTextStyle,
          )),
          const DataColumn(label: Text(""))
        ],
        rows: chooseLayoutArgs.layoutRuangan
            .mapIndexed((index, value) => DataRow(cells: [
                  DataCell(Text(
                    (index + 1).toString(),
                    style: cellTextStyle,
                  )),
                  DataCell(Text(value.jumlahMejaBaris.toString(),
                      style: cellTextStyle)),
                  DataCell(Text(value.jumlahMejaKolom.toString(),
                      style: cellTextStyle)),
                  DataCell(Text(value.kapasitasPeserta.toString(),
                      style: cellTextStyle)),
                  DataCell(PrimaryButton(
                    "Pilih",
                    onPressed: () {
                      showDialog(context, value);
                    },
                  ))
                ]))
            .toList());
  }
}
