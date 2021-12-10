class Country implements Comparable<Country> {
  final String _name;
  final String _alpha2Code;

  Country({required name, required alpha2Code})
      : _name = name,
        _alpha2Code = alpha2Code;

  int compareTo(Country other) {
    return _name.compareTo(other.name);
  }

  String get name => _name;
  String get alpha2Code => _alpha2Code;
}
