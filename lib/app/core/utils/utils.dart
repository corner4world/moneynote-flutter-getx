String accountTabIndexToType(int index) {
  switch (index) {
    case 0:
      return 'CHECKING';
    case 1:
      return 'CREDIT';
    case 2:
      return 'ASSET';
    case 3:
      return 'DEBT';
  }
  throw Exception('tab index error');
}