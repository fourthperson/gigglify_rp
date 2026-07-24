enum GigThemeMode {
  system('system'),
  light('light'),
  dark('dark');

  static GigThemeMode fromString(String value) {
    return GigThemeMode.values.firstWhere(
      (mode) => mode.value == value,
      orElse: () => GigThemeMode.system,
    );
  }

  final String value;

  const GigThemeMode(this.value);
}
