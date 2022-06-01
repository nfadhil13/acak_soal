class DataMeja {
  final double panjang;
  final double lebar;

  const DataMeja({required this.panjang, required this.lebar});

  factory DataMeja.init() => const DataMeja(panjang: -1, lebar: -1);

  DataMeja copyWith({double? panjang, double? lebar}) =>
      DataMeja(panjang: panjang ?? this.panjang, lebar: lebar ?? this.lebar);
}
