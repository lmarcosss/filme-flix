class DateFormatter {
  static String getYearFromStringDate(String dateString) {
    if (dateString.isEmpty) return "";

    final date = DateTime.parse(dateString);

    return date.year.toString();
  }
}
