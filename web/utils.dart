void parseFavorites(Map<String, dynamic> f) {
  f.removeWhere((key, value) => key.startsWith('_') || key == '\$ti');
}
