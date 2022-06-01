import 'dart:typed_data';

import '../../../common/domain/model/data_input_ujian.dart';
import '../../../common/domain/model/layout_ruangan.dart';


class ChooseLayoutArgs{
  final DataInputUjian dataInputUjian;
  final Uint8List file;
  final List<LayoutRuangan> layoutRuangan;

  ChooseLayoutArgs(this.dataInputUjian, this.file, this.layoutRuangan);
}




