enum SortType {
  nameAscending,
  nameDescending,
  populationAscending,
  populationDescending,
}

extension SortTypeExtension on SortType {
  String get displayName {
    switch (this) {
      case SortType.nameAscending:
        return 'Name (A-Z)';
      case SortType.nameDescending:
        return 'Name (Z-A)';
      case SortType.populationAscending:
        return 'Population (Low-High)';
      case SortType.populationDescending:
        return 'Population (High-Low)';
    }
  }
}
