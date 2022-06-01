part of '../result_screen.dart';

class _BaseDataTable extends StatelessWidget {
  final String title;
  final Map<String, String> data;
  const _BaseDataTable({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final columnTextStyle = TextStyle(
        color: ColorTheme.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 16);

    final cellTextStyle = columnTextStyle.copyWith(
        fontWeight: FontWeight.normal, color: Colors.black);
    return Column(
      children: [
        Text(title,
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 20),
        SizedBox(
          width: 500,
          child: DataTable(
              
              columns: [
                DataColumn(
                    label: Text(
                  "Nama Data",
                  style: columnTextStyle,
                )),
                DataColumn(
                    label: Text(
                  "Nilai",
                  style: columnTextStyle,
                ))
              ],
              rows: data.entries
                  .map((e) => DataRow(cells: [
                        DataCell(Text(
                          e.key,
                          style: cellTextStyle,
                        )),
                        DataCell(Text(
                          e.value,
                          style: cellTextStyle,
                        ))
                      ]))
                  .toList()),
        )
      ],
    );
  }
}
