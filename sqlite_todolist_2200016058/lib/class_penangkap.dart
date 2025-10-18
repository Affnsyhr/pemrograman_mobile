class ClassPenangkap {
  int? _id;
  String _name;
  String _phone;

  ClassPenangkap(this._name, this._phone, [this._id]);

  ClassPenangkap.fromMap(Map<String, dynamic> map)
    : _id = map['id'] as int?,
      _name = map['name'] as String? ?? '',
      _phone = map['phone'] as String? ?? '';

  int? get id => _id;
  String get name => _name;
  String get phone => _phone;

  set id(int? value) => _id = value;
  set name(String value) => _name = value;
  set phone(String value) => _phone = value;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (_id != null) map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }
}
