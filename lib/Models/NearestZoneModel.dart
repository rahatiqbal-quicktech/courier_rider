class NearestZoneModel {
  int _id;
  String _zonename;
  int _status;
  String _createdAt;
  String _updatedAt;

  NearestZoneModel(
      {int id,
        String zonename,
        int status,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._zonename = zonename;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get zonename => _zonename;
  set zonename(String zonename) => _zonename = zonename;
  int get status => _status;
  set status(int status) => _status = status;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  NearestZoneModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _zonename = json['zonename'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['zonename'] = this._zonename;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
