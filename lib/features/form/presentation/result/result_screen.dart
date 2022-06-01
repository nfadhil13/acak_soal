import 'dart:io' show Platform;
import 'dart:js' as js;
import 'dart:typed_data';
import 'package:acak_soal/core/ext/ctx_ext.dart';
import 'package:acak_soal/core/ext/list_ext.dart';
import 'package:acak_soal/core/service_locator/injection_container.dart';
import 'package:acak_soal/features/common/domain/model/data_input_ujian.dart';
import 'package:acak_soal/features/common/domain/model/data_ketetanggaan.dart';
import 'package:acak_soal/features/common/domain/model/data_meja.dart';
import 'package:acak_soal/features/common/domain/model/data_pengacakan.dart';
import 'package:acak_soal/features/common/domain/model/data_ruangan.dart';
import 'package:acak_soal/features/common/domain/model/data_ujian_final.dart';
import 'package:acak_soal/features/common/domain/model/layout_ruangan.dart';
import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/base_widgets/wrapper/form_wrapper.dart';
import '../../../../core/style/color.dart';
import '../../../common/data/datasource/pengacakan_network_data_source.dart';
import '../../../landing_page/presentation/landing_screen.dart';

part 'widgets/data_ruangan.dart';
part 'widgets/data_meja.dart';
part 'widgets/base_data_table.dart';
part 'widgets/data_ujian.dart';
part 'widgets/data_layout_ruangan.dart';
part 'widgets/denah_ruangan.dart';
part 'widgets/download_json.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = "/result";
  final DataUjianFinal? dataUjianFinal;
  const ResultScreen({Key? key, this.dataUjianFinal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = dataUjianFinal ??
        ModalRoute.of(context)?.settings.arguments as DataUjianFinal?;
    if (args != null) {
      return _ResultScreenValid(dataUjianFinal: args);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.popAndPushNamed(context, LandingScreen.routName);
    });
    return const SizedBox();
  }
}

class _ResultScreenValid extends StatelessWidget {
  final DataUjianFinal dataUjianFinal;
  const _ResultScreenValid({Key? key, required this.dataUjianFinal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
                child: FormWrapper(
                    child: Column(
              children: [
                const SizedBox(height: 100),
                Text(
                  "Proses Pengacakan & Distribusi Berhasil",
                  style: context.textTheme.headline2?.copyWith(
                      color: ColorTheme.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const Text("Anda berhasil melakuka proses pengacakan"),
                const Text("dan penentuan distribusi soal"),
                const SizedBox(height: 50),
                _DataRuangan(dataRuangan: dataUjianFinal.dataRuangan),
                const SizedBox(height: 50),
                _DataMeja(dataMeja: dataUjianFinal.dataRuangan.dataMeja),
                const SizedBox(height: 50),
                _DataUjian(
                    dataPengacakan: dataUjianFinal.dataPengacakan,
                    jumlahPeserta: dataUjianFinal.jumlahPeserta),
                const SizedBox(height: 50),
                _DataLayoutRuagan(layoutRuangan: dataUjianFinal.layoutRuangan),
                const SizedBox(height: 50),
                _DownloadJSON(
                    downloadURL: dataUjianFinal.dataPengacakan.paketURL),
                const SizedBox(height: 50),
                Text("Denah Ruangan",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 20),
                _DenahRuangan(
                    jumlahPeserta: dataUjianFinal.jumlahPeserta,
                    layoutRuangan: dataUjianFinal.layoutRuangan,
                    dataKetanggan: dataUjianFinal.listKetetanggaan,
                    dataRuangan: dataUjianFinal.dataRuangan),
                SizedBox(height: MediaQuery.of(context).size.height / 2)
              ],
            ))),
          ],
        ),
      ),
    );
  }
}

class ResultScreenTest extends StatelessWidget {
  const ResultScreenTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder<DataUjianFinal>(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ResultScreen(dataUjianFinal: snapshot.data);
          }
          return const SizedBox();
        }),
        future: getIt<PengacakanNetworkDataSource>().startAcak(
            dataInputUjian: DataInputUjian(
                DataRuangan(
                    panjangHorizontal: 500,
                    panjangVertical: 1000,
                    dataMeja: const DataMeja(lebar: 60, panjang: 50)),
                10),
            dataSoal: Uint8List(0),
            layoutRuangan: LayoutRuangan(
                jarakAntarBaris: 110,
                jarakAntarKolom: 110,
                kapasitasPeserta: 18,
                jumlahMejaBaris: 3,
                jumlahMejaKolom: 6)),
      );
}
