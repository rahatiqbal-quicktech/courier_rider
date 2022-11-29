class ParcelTrackModel {
  bool _success;
  dynamic _message;
  List<Data> _data;

  ParcelTrackModel({bool success, dynamic message, List<Data> data}) {
    this._success = success;
    this._message = message;
    this._data = data;
  }

  bool get success => _success;
  set success(bool success) => _success = success;
  dynamic get message => _message;
  set message(dynamic message) => _message = message;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  ParcelTrackModel.fromJson(Map<dynamic, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic _id;
  dynamic _parcelId;
  dynamic _note;
  dynamic _createdAt;
  dynamic _updatedAt;

  Data(
      {dynamic id,
      dynamic parcelId,
      dynamic note,
      dynamic createdAt,
      dynamic updatedAt}) {
    this._id = id;
    this._parcelId = parcelId;
    this._note = note;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  dynamic get id => _id;
  set id(dynamic id) => _id = id;
  dynamic get parcelId => _parcelId;
  set parcelId(dynamic parcelId) => _parcelId = parcelId;
  dynamic get note => _note;
  set note(dynamic note) => _note = note;
  dynamic get createdAt => _createdAt;
  set createdAt(dynamic createdAt) => _createdAt = createdAt;
  dynamic get updatedAt => _updatedAt;
  set updatedAt(dynamic updatedAt) => _updatedAt = updatedAt;

  Data.fromJson(Map<dynamic, dynamic> json) {
    _id = json['id'];
    _parcelId = json['parcelId'];
    _note = json['note'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this._id;
    data['parcelId'] = this._parcelId;
    data['note'] = this._note;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
