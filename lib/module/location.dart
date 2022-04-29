class Location {
  final String _address;
  final Map _position;
  int get X => _position['X'];
  int get Y => _position['Y'];
  String get address => _address;
  String get name => _address.split(' ').last;

  Location(this._address, this._position);
  Location.fromJson(Map<String, dynamic> json)
      : _address = json['address'],
        _position = {'X': json['X'], 'Y': json['Y']};

  Map<String, dynamic> toJson() {
    return {'address': _address, 'X': X, 'Y': Y};
  }
}
