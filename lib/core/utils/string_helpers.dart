class StringHelpers {
  static String greeting() {
    return DateTime.now().hour < 12 ? 'Good morning' : 'Good afternoon';
  }
}
