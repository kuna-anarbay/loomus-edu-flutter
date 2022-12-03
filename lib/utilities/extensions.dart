extension MyIterable<E> on Iterable<E> {
  Iterable<E> ascendingBy(Comparable Function(E e) key) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}

extension DescIterable<E> on Iterable<E> {
  Iterable<E> descendingBy(Comparable Function(E e) key) =>
      toList()..sort((a, b) => key(b).compareTo(key(a)));
}
