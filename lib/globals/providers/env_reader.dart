class ENV {
  static String get baseUrl {
    final raw = const String.fromEnvironment("BASE_URL");
    // Remove surrounding double quotes if present.
    if (raw.startsWith('"') && raw.endsWith('"')) {
      return raw.substring(1, raw.length - 1);
    }
    return raw;
  }
}
