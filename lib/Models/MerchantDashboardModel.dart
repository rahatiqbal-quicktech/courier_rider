class MerchantDashboardModel {
  int _placePercel;
  int _pendingParcel;
  int _delivered;
  int _cancelParcel;
  int _parcelReturn;
  int _totalHold;
  int _totalAmount;
  int _merchantUnPaid;
  int _merchantPaid;

  MerchantDashboardModel(
      {int placePercel,
        int pendingParcel,
        int delivered,
        int cancelParcel,
        int parcelReturn,
        int totalHold,
        int totalAmount,
        int merchantUnPaid,
        int merchantPaid}) {
    this._placePercel = placePercel;
    this._pendingParcel = pendingParcel;
    this._delivered = delivered;
    this._cancelParcel = cancelParcel;
    this._parcelReturn = parcelReturn;
    this._totalHold = totalHold;
    this._totalAmount = totalAmount;
    this._merchantUnPaid = merchantUnPaid;
    this._merchantPaid = merchantPaid;
  }

  int get placePercel => _placePercel;
  set placePercel(int placePercel) => _placePercel = placePercel;
  int get pendingParcel => _pendingParcel;
  set pendingParcel(int pendingParcel) => _pendingParcel = pendingParcel;
  int get delivered => _delivered;
  set delivered(int delivered) => _delivered = delivered;
  int get cancelParcel => _cancelParcel;
  set cancelParcel(int cancelParcel) => _cancelParcel = cancelParcel;
  int get parcelReturn => _parcelReturn;
  set parcelReturn(int parcelReturn) => _parcelReturn = parcelReturn;
  int get totalHold => _totalHold;
  set totalHold(int totalHold) => _totalHold = totalHold;
  int get totalAmount => _totalAmount;
  set totalAmount(int totalAmount) => _totalAmount = totalAmount;
  int get merchantUnPaid => _merchantUnPaid;
  set merchantUnPaid(int merchantUnPaid) => _merchantUnPaid = merchantUnPaid;
  int get merchantPaid => _merchantPaid;
  set merchantPaid(int merchantPaid) => _merchantPaid = merchantPaid;

  MerchantDashboardModel.fromJson(Map<String, dynamic> json) {
    _placePercel = json['placePercel'];
    _pendingParcel = json['pendingParcel'];
    _delivered = json['delivered'];
    _cancelParcel = json['cancelParcel'];
    _parcelReturn = json['parcelReturn'];
    _totalHold = json['totalHold'];
    _totalAmount = json['totalAmount'];
    _merchantUnPaid = json['merchantUnPaid'];
    _merchantPaid = json['merchantPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placePercel'] = this._placePercel;
    data['pendingParcel'] = this._pendingParcel;
    data['delivered'] = this._delivered;
    data['cancelParcel'] = this._cancelParcel;
    data['parcelReturn'] = this._parcelReturn;
    data['totalHold'] = this._totalHold;
    data['totalAmount'] = this._totalAmount;
    data['merchantUnPaid'] = this._merchantUnPaid;
    data['merchantPaid'] = this._merchantPaid;
    return data;
  }
}
