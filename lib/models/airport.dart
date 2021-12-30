class Airport {
  static final anywhereDestination = Airport(
      name: 'Anywhere', countryName: '', countryAlpha2Code: '', iataCode: '');

  final String _name;
  final String _countryName;
  final String _countryAlpha2Code;
  final String _iataCode;

  Airport(
      {required name,
      required countryName,
      required countryAlpha2Code,
      required iataCode})
      : _name = name,
        _countryName = countryName,
        _countryAlpha2Code = countryAlpha2Code,
        _iataCode = iataCode;

  factory Airport.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final countryName = data['countryName'] as String;
    final countryAlpha2Code = data['city']['countryCode'] as String;
    final iataCode = data['iataCode'] as String;

    return Airport(
        name: name,
        countryName: countryName,
        countryAlpha2Code: countryAlpha2Code,
        iataCode: iataCode);
  }

  String get name => _name;
  String get countryName => _countryName;
  String get countryAlpha2Code => _countryAlpha2Code;
  String get iataCode => _iataCode;
}
