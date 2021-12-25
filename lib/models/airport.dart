class Airport {
  final String _name;
  final String _country;
  final String _countryAlpha2Code;
  final String _iataCode;

  Airport(
      {required name,
      required country,
      required countryAlpha2Code,
      required iataCode})
      : _name = name,
        _country = country,
        _countryAlpha2Code = countryAlpha2Code,
        _iataCode = iataCode;

  String get name => _name;
  String get country => _country;
  String get countryAlpha2Code => _countryAlpha2Code;
  String get iataCode => _iataCode;
}
