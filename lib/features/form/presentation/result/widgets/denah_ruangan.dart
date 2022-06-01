part of '../result_screen.dart';

enum _Position {
  bottomLeft,
  bottomRight,
  topRight,
  // // Posisi end di kiri atas start
  topLeft,

  bottom,
  // Posisi End diatas Start
  top,
  // Posisi End dikiri Start
  left,
  // Posisi End dikanan Start
  right;

  factory _Position.generate(Offset start, Offset end) {
    if (end.dy < start.dy) {
      if (end.dx == start.dx) return _Position.top;
      if (end.dx >= start.dx) return _Position.topRight;
      return _Position.topLeft;
    }
    if (end.dy > start.dy) {
      if (end.dx == start.dx) return _Position.bottom;
      if (end.dx >= start.dx) return _Position.bottomRight;
      return _Position.bottomLeft;
    }
    if (start.dx < end.dx) return _Position.right;
    return _Position.left;
  }
}

class _NodeData {
  final double height;
  final double width;
  final Offset localOffset;

  _NodeData(this.height, this.width, this.localOffset);

  get dx => localOffset.dx;

  get dy => localOffset.dy;
}

class _DenahRuangan extends StatelessWidget {
  final LayoutRuangan layoutRuangan;
  final DataRuangan dataRuangan;
  final List<DataKetetanggaan> dataKetanggan;
  final int jumlahPeserta;
  final bool isScreenShoot;
  const _DenahRuangan(
      {Key? key,
      required this.layoutRuangan,
      required this.dataRuangan,
      required this.dataKetanggan,
      required this.jumlahPeserta,
      this.isScreenShoot = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isScreenShoot) {
      return SingleChildScrollView(
        child: _DenahRuanganContent(
            layoutRuangan: layoutRuangan,
            dataRuangan: dataRuangan,
            dataKetanggan: dataKetanggan,
            jumlahPeserta: jumlahPeserta,
            width: 1000),
      );
    }
    return LayoutBuilder(builder: ((context, constraints) {
      return _DenahRuanganContent(
          layoutRuangan: layoutRuangan,
          dataRuangan: dataRuangan,
          dataKetanggan: dataKetanggan,
          jumlahPeserta: jumlahPeserta,
          width: constraints.maxWidth);
    }));
  }
}

class _DenahRuanganContent extends StatefulWidget {
  static const colors = [
    Colors.red,
    Colors.blue,
    Colors.amber,
    Colors.deepPurple,
    Colors.green,
    Colors.teal,
    Colors.pink,
    Colors.orange,
    Colors.lightBlue
  ];
  static const unusedChair = Colors.black;
  final LayoutRuangan layoutRuangan;
  final DataRuangan dataRuangan;
  final List<DataKetetanggaan> dataKetanggan;
  final int jumlahPeserta;
  final double width;
  const _DenahRuanganContent(
      {Key? key,
      required this.layoutRuangan,
      required this.dataRuangan,
      required this.dataKetanggan,
      required this.jumlahPeserta,
      required this.width})
      : super(key: key);

  @override
  State<_DenahRuanganContent> createState() => _DenahRuanganState();
}

class _DenahRuanganState extends State<_DenahRuanganContent> {
  final childList = <GlobalKey>[];
  late GlobalKey _stackKey;
  final _toggle = [false, false, false];

  @override
  void initState() {
    childList.addAll(widget.dataKetanggan.map((e) => GlobalKey()));
    _stackKey = GlobalKey();
    super.initState();
  }

  List<CustomPaint> drawLines() {
    final listOfLine = <CustomPaint>[];
    var index = 0;
    for (var element in widget.dataKetanggan) {
      final startOffset = getNodeData(childList[index]);
      if (startOffset == null) return [];
      for (var dest in element.adjacentList) {
        if (dest >= widget.jumlahPeserta) continue;
        final endOffset = getNodeData(childList[dest]);
        if (endOffset == null) continue;
        if (index <= widget.jumlahPeserta) {
          listOfLine
              .add(CustomPaint(painter: _LinesPainter(startOffset, endOffset)));
        }
      }
      index++;
      if (index > widget.jumlahPeserta - 1) return listOfLine;
    }
    return listOfLine;
  }

  _NodeData? getNodeData(GlobalKey key) {
    final startRenderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (startRenderBox == null) return null;
    final startTopOffset = startRenderBox.localToGlobal(Offset.zero);
    final startWidth = startRenderBox.size.width;
    final startHeight = startRenderBox.size.height;
    final RenderBox parent =
        _stackKey.currentContext?.findRenderObject() as RenderBox;
    Offset childRelativeToParent = parent.globalToLocal(startTopOffset);
    return _NodeData(startHeight, startWidth, childRelativeToParent);
  }

  @override
  Widget build(BuildContext context) {
    final pixelWidth = widget.width * 0.8;
    final cmToPixelRatio = pixelWidth / widget.dataRuangan.panjangHorizontal;
    final pixelHeight = cmToPixelRatio * widget.dataRuangan.panjangVertical;
    final mejaHeight = cmToPixelRatio * widget.dataRuangan.dataMeja.lebar;
    final mejaWidth = cmToPixelRatio * widget.dataRuangan.dataMeja.panjang;
    final jarakBaris = cmToPixelRatio * widget.layoutRuangan.jarakAntarBaris;
    final jarakKolom = cmToPixelRatio * widget.layoutRuangan.jarakAntarKolom;
    final papanTulis = pixelHeight * 0.03;
    const papanTulisToMejaSpacing = 100.0;
    return Column(
      children: [
        // ToggleButtons(
        //   onPressed: (int index) {
        //     setState(() {
        //       _toggle[index] = !_toggle[index];
        //     });
        //   },
        //   isSelected: _toggle,
        //   children: <Widget>[
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         children: const [
        //           Icon(Icons.people),
        //           Text("Tampilkan Graf Ketetanggan")
        //         ],
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         children: const [
        //           Icon(Icons.data_array),
        //           Text("Tampilkan Data Layout Ruagan")
        //         ],
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         children: const [
        //           Icon(Icons.table_bar),
        //           Text("Tampilkan Meja Kosong")
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        if (_toggle[1]) const SizedBox(height: 20),
        if (_toggle[1])
          SizedBox(
            width: pixelWidth + 20 + 14,
            child: Column(
              children: [
                Text(
                  "Panjang Horizontal Ruangan : ${widget.dataRuangan.panjangHorizontal / 100} Meter ",
                  style: const TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 34),
                    Container(height: 14, width: 5, color: Colors.black),
                    Expanded(
                        child: Container(
                      height: 4,
                      width: double.infinity,
                      color: Colors.black,
                    )),
                    Container(height: 14, width: 5, color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_toggle[1])
              SizedBox(
                height: pixelHeight + papanTulis + papanTulisToMejaSpacing,
                child: Column(
                  children: [
                    Container(height: 5, width: 14, color: Colors.black),
                    Expanded(
                        child: Container(
                      width: 4,
                      height: double.infinity,
                      color: Colors.black,
                    )),
                    Container(height: 5, width: 14, color: Colors.black),
                  ],
                ),
              ),
            const SizedBox(width: 20),
            Container(
              width: pixelWidth,
              height: pixelHeight + papanTulis + papanTulisToMejaSpacing,
              color: const Color(0xffD9D9D9),
              child: Stack(
                key: _stackKey,
                children: [
                  if (_toggle[0]) ...drawLines(),
                  Positioned.fill(
                    child: Column(
                      children: [
                        Container(
                          height: papanTulis,
                          width: pixelWidth * 0.5,
                          padding: const EdgeInsets.all(10),
                          color: Colors.black,
                          child: const FittedBox(
                              child: Text(
                            "Papan Tulis",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        const SizedBox(
                          height: papanTulisToMejaSpacing,
                        ),
                        Expanded(
                          child: Wrap(
                              runSpacing: jarakBaris,
                              spacing: jarakKolom,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: widget.dataKetanggan.mapIndexed((i, e) {
                                final isMejaKosong = i >= widget.jumlahPeserta;
                                final kolom =
                                    widget.layoutRuangan.jumlahMejaKolom;
                                final indexPlusOne = i + 1;
                                final barisMeja = (indexPlusOne ~/ kolom +
                                    (indexPlusOne % kolom > 0 ? 1 : 0));
                                final indexAwalBaris = (barisMeja - 1) * kolom;
                                final isAwalBarisDrawn =
                                    indexAwalBaris < widget.jumlahPeserta;
                                final shouldDraw = !isMejaKosong ||
                                    isAwalBarisDrawn ||
                                    _toggle[2];
                                if (!shouldDraw) return const SizedBox();
                                return Container(
                                  key: childList[i],
                                  width: mejaHeight,
                                  height: mejaWidth,
                                  padding: const EdgeInsets.all(10),
                                  color: () {
                                    if (!isMejaKosong) {
                                      return _DenahRuanganContent
                                          .colors[e.nomorPaket];
                                    }
                                    if (isMejaKosong && _toggle[2]) {
                                      return _DenahRuanganContent.unusedChair;
                                    }
                                    return null;
                                  }(),
                                  child: () {
                                    if (isMejaKosong && !_toggle[2]) {
                                      return const SizedBox();
                                    }
                                    return FittedBox(
                                        child: Text(
                                            i >= widget.jumlahPeserta
                                                ? "Kosong"
                                                : "paket ${e.nomorPaket + 1}",
                                            style: const TextStyle(
                                                color: Colors.white)));
                                  }(),
                                );
                              }).toList()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LinesPainter extends CustomPainter {
  final _NodeData start, end;

  _LinesPainter(this.start, this.end);

  Offset getOffset(_NodeData start, _NodeData end) {
    final endRelativeToStart =
        _Position.generate(start.localOffset, end.localOffset);
    switch (endRelativeToStart) {
      case _Position.left:
        return Offset(start.dx, start.dy + start.height / 2);
      case _Position.right:
        return Offset(start.dx + start.width, start.dy + start.height / 2);
      case _Position.top:
        return Offset(start.dx + start.width / 2, start.dy);
      case _Position.bottom:
        return Offset(start.dx + start.width / 2, start.dy + start.height);
      case _Position.topLeft:
        return Offset(start.dx, start.dy);
      case _Position.topRight:
        return Offset(start.dx + start.width, start.dy);
      case _Position.bottomLeft:
        return Offset(start.dx, start.dy + start.height);
      case _Position.bottomRight:
        return Offset(start.dx + start.width, start.dy + start.height);
    }
  }

  Offset firstLineOffset(_Position endRelativeToStart, Offset endOffset,
      double arrowLength, double arrowHeight) {
    switch (endRelativeToStart) {
      case _Position.left:
        return Offset(endOffset.dx + arrowLength, endOffset.dy + arrowHeight);
      case _Position.right:
        return Offset(endOffset.dx - arrowLength, endOffset.dy + arrowHeight);
      case _Position.top:
        return Offset(endOffset.dx - arrowHeight, endOffset.dy + arrowLength);
      case _Position.bottom:
        return Offset(endOffset.dx - arrowHeight, endOffset.dy - arrowLength);
      case _Position.topLeft:
        return Offset(
            endOffset.dx + arrowHeight, endOffset.dy + arrowLength * 0.3);
      case _Position.topRight:
        return Offset(
            endOffset.dx - arrowLength * 0.7, endOffset.dy + arrowHeight);
      case _Position.bottomLeft:
        return Offset(0, 0);
      case _Position.bottomRight:
        return Offset(endOffset.dx + arrowHeight, endOffset.dy - arrowHeight);
    }
  }

  Offset secondLineOffset(_Position endRelativeToStart, Offset endOffset,
      double arrowLength, double arrowHeight) {
    switch (endRelativeToStart) {
      case _Position.left:
        return Offset(endOffset.dx + arrowLength, endOffset.dy - arrowHeight);
      case _Position.right:
        return Offset(endOffset.dx - arrowLength, endOffset.dy - arrowHeight);
      case _Position.top:
        return Offset(endOffset.dx + arrowHeight, endOffset.dy + arrowLength);
      case _Position.bottom:
        return Offset(endOffset.dx + arrowHeight, endOffset.dy - arrowLength);
      case _Position.topLeft:
        return Offset(
            endOffset.dx - arrowHeight / 2, endOffset.dy + arrowLength * 0.4);
      case _Position.topRight:
        return Offset(
            endOffset.dx + arrowLength * 0.4, endOffset.dy + arrowHeight);
      case _Position.bottomLeft:
        return Offset(0, 0);
      case _Position.bottomRight:
        return Offset(0, 0);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final startOffset = getOffset(start, end);
    final endOffset = getOffset(end, start);
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    var path = Path();
    path.moveTo(startOffset.dx, startOffset.dy);
    path.lineTo(endOffset.dx, endOffset.dy);
    path = ArrowPath.make(path: path);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_LinesPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end;
  }
}
