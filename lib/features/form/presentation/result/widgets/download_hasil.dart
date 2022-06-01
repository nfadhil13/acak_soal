part of '../result_screen.dart';

class _DownloadHasil extends StatelessWidget {
  final DataUjianFinal dataUjianFinal;
  const _DownloadHasil({Key? key, required this.dataUjianFinal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Simpan Paket Soal dan Hasil Distribusi",
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 20),
        OutlinedButton.icon(
            onPressed: () {
              final pages = [
                _DataRuangan(dataRuangan: dataUjianFinal.dataRuangan),
                _DataMeja(dataMeja: dataUjianFinal.dataRuangan.dataMeja),
                _DataUjian(
                    dataPengacakan: dataUjianFinal.dataPengacakan,
                    jumlahPeserta: dataUjianFinal.jumlahPeserta),
                _DataLayoutRuagan(layoutRuangan: dataUjianFinal.layoutRuangan),
                _DenahRuangan(
                    isScreenshot: true,
                    jumlahPeserta: dataUjianFinal.jumlahPeserta,
                    layoutRuangan: dataUjianFinal.layoutRuangan,
                    dataKetanggan: dataUjianFinal.listKetetanggaan,
                    dataRuangan: dataUjianFinal.dataRuangan)
              ];
              GetResultToEmailScreen.showAsDialog(context, pages, dataUjianFinal.dataPengacakan.filePath);
            },
            icon: const Icon(
              Icons.download,
              color: Colors.black,
            ),
            label: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Simpan",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            )),
        const SizedBox(height: 20),
        const Text(
            "Dapatkan hasil pengacakan dan distribusi melalui email dalam bentuk pdf",
            textAlign: TextAlign.center,
            style: TextStyle(fontStyle: FontStyle.italic))
      ],
    );
  }
}
