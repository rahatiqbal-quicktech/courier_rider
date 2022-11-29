class DeliverymanDashboardModel {
  int totalParcel;
  int totalPickup;
  int totalPending;
  int totalInTransit;
  int totalDelivery;
  int totalHold;
  int totalCancel;
  int returnPending;
  int totalAmount;
  int unpaidAmount;
  int pickup;
  int paidAmount;

  DeliverymanDashboardModel(
      {this.totalParcel,
      this.totalPending,
      this.totalPickup,
      this.totalInTransit,
      this.totalDelivery,
      this.totalHold,
      this.totalCancel,
      this.returnPending,
      this.totalAmount,
      this.unpaidAmount,
      this.pickup,
      this.paidAmount});

  DeliverymanDashboardModel.fromJson(Map<String, dynamic> json) {
    totalParcel = json['totalParcel'];
    totalPickup = json['totalPickup'];
    totalPending = json['totalPending'];
    totalInTransit = json['totalInTransit'];
    totalDelivery = json['totalDelivery'];
    totalHold = json['totalHold'];
    totalCancel = json['totalCancel'];
    returnPending = json['returnPending'];
    totalAmount = json['totalAmount'];
    unpaidAmount = json['unpaidAmount'];
    pickup = json['pickup'];
    paidAmount = json['paidAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalParcel'] = this.totalParcel;
    data['totalPickup'] = this.totalPickup;
    data['totalPending'] = this.totalPending;
    data['totalInTransit'] = this.totalInTransit;
    data['totalDelivery'] = this.totalDelivery;
    data['totalHold'] = this.totalHold;
    data['totalCancel'] = this.totalCancel;
    data['returnPending'] = this.returnPending;
    data['totalAmount'] = this.totalAmount;
    data['unpaidAmount'] = this.unpaidAmount;
    data['pickup'] = this.pickup;
    data['paidAmount'] = this.paidAmount;
    return data;
  }
}
