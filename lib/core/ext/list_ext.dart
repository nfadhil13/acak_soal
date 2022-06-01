extension ListExtension<E> on List<E> {
  List<T> mapIndexed<T>(T Function(int index, E item) mapper) =>
      asMap().entries.map((e) => mapper(e.key, e.value)).toList();

  Map<Key, Value> toMap<Key, Value>(
      MapEntry<Key, Value> Function(E item) mapper) {
    final Map<Key, Value> result = {};
    for (var element in this) {
      final mapped = mapper(element);
      result[mapped.key] = mapped.value;
    }
    return result;
  }
}
