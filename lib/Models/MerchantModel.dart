class MerchantModel {
  int _id;
  String _firstName;
  String _lastName;
  String _username;
  String _companyName;
  String _pickLocation;
  int _phoneNumber;
  String _emailAddress;
  int _nearestZone;
  int _pickupPreference;
  String _socialLink;
  int _paymentMethod;
  String _paymentmode;
  int _withdrawal;
  String _nameOfBank;
  String _bankBranch;
  String _bankAcHolder;
  int _bankAcNo;
  int _bkashNumber;
  int _roketNumber;
  int _nogodNumber;
  int _balance;
  String _password;
  String _passwordReset;
  String _logo;
  String _agree;
  int _verify;
  int _status;
  String _createdAt;
  String _updatedAt;

  MerchantModel(
      {int id,
        String firstName,
        String lastName,
        String username,
        String companyName,
        String pickLocation,
        int phoneNumber,
        String emailAddress,
        int nearestZone,
        int pickupPreference,
        String socialLink,
        int paymentMethod,
        String paymentmode,
        int withdrawal,
        String nameOfBank,
        String bankBranch,
        String bankAcHolder,
        int bankAcNo,
        int bkashNumber,
        int roketNumber,
        int nogodNumber,
        int balance,
        String password,
        String passwordReset,
        String logo,
        String agree,
        int verify,
        int status,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._firstName = firstName;
    this._lastName = lastName;
    this._username = username;
    this._companyName = companyName;
    this._pickLocation = pickLocation;
    this._phoneNumber = phoneNumber;
    this._emailAddress = emailAddress;
    this._nearestZone = nearestZone;
    this._pickupPreference = pickupPreference;
    this._socialLink = socialLink;
    this._paymentMethod = paymentMethod;
    this._paymentmode = paymentmode;
    this._withdrawal = withdrawal;
    this._nameOfBank = nameOfBank;
    this._bankBranch = bankBranch;
    this._bankAcHolder = bankAcHolder;
    this._bankAcNo = bankAcNo;
    this._bkashNumber = bkashNumber;
    this._roketNumber = roketNumber;
    this._nogodNumber = nogodNumber;
    this._balance = balance;
    this._password = password;
    this._passwordReset = passwordReset;
    this._logo = logo;
    this._agree = agree;
    this._verify = verify;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get username => _username;
  set username(String username) => _username = username;
  String get companyName => _companyName;
  set companyName(String companyName) => _companyName = companyName;
  String get pickLocation => _pickLocation;
  set pickLocation(String pickLocation) => _pickLocation = pickLocation;
  int get phoneNumber => _phoneNumber;
  set phoneNumber(int phoneNumber) => _phoneNumber = phoneNumber;
  String get emailAddress => _emailAddress;
  set emailAddress(String emailAddress) => _emailAddress = emailAddress;
  int get nearestZone => _nearestZone;
  set nearestZone(int nearestZone) => _nearestZone = nearestZone;
  int get pickupPreference => _pickupPreference;
  set pickupPreference(int pickupPreference) =>
      _pickupPreference = pickupPreference;
  String get socialLink => _socialLink;
  set socialLink(String socialLink) => _socialLink = socialLink;
  int get paymentMethod => _paymentMethod;
  set paymentMethod(int paymentMethod) => _paymentMethod = paymentMethod;
  String get paymentmode => _paymentmode;
  set paymentmode(String paymentmode) => _paymentmode = paymentmode;
  int get withdrawal => _withdrawal;
  set withdrawal(int withdrawal) => _withdrawal = withdrawal;
  String get nameOfBank => _nameOfBank;
  set nameOfBank(String nameOfBank) => _nameOfBank = nameOfBank;
  String get bankBranch => _bankBranch;
  set bankBranch(String bankBranch) => _bankBranch = bankBranch;
  String get bankAcHolder => _bankAcHolder;
  set bankAcHolder(String bankAcHolder) => _bankAcHolder = bankAcHolder;
  int get bankAcNo => _bankAcNo;
  set bankAcNo(int bankAcNo) => _bankAcNo = bankAcNo;
  int get bkashNumber => _bkashNumber;
  set bkashNumber(int bkashNumber) => _bkashNumber = bkashNumber;
  int get roketNumber => _roketNumber;
  set roketNumber(int roketNumber) => _roketNumber = roketNumber;
  int get nogodNumber => _nogodNumber;
  set nogodNumber(int nogodNumber) => _nogodNumber = nogodNumber;
  int get balance => _balance;
  set balance(int balance) => _balance = balance;
  String get password => _password;
  set password(String password) => _password = password;
  String get passwordReset => _passwordReset;
  set passwordReset(String passwordReset) => _passwordReset = passwordReset;
  String get logo => _logo;
  set logo(String logo) => _logo = logo;
  String get agree => _agree;
  set agree(String agree) => _agree = agree;
  int get verify => _verify;
  set verify(int verify) => _verify = verify;
  int get status => _status;
  set status(int status) => _status = status;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;

  MerchantModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _username = json['username'];
    _companyName = json['companyName'];
    _pickLocation = json['pickLocation'];
    _phoneNumber = json['phoneNumber'];
    _emailAddress = json['emailAddress'];
    _nearestZone = json['nearestZone'];
    _pickupPreference = json['pickupPreference'];
    _socialLink = json['socialLink'];
    _paymentMethod = json['paymentMethod'];
    _paymentmode = json['paymentmode'];
    _withdrawal = json['withdrawal'];
    _nameOfBank = json['nameOfBank'];
    _bankBranch = json['bankBranch'];
    _bankAcHolder = json['bankAcHolder'];
    _bankAcNo = json['bankAcNo'];
    _bkashNumber = json['bkashNumber'];
    _roketNumber = json['roketNumber'];
    _nogodNumber = json['nogodNumber'];
    _balance = json['balance'];
    _password = json['password'];
    _passwordReset = json['passwordReset'];
    _logo = json['logo'];
    _agree = json['agree'];
    _verify = json['verify'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['username'] = this._username;
    data['companyName'] = this._companyName;
    data['pickLocation'] = this._pickLocation;
    data['phoneNumber'] = this._phoneNumber;
    data['emailAddress'] = this._emailAddress;
    data['nearestZone'] = this._nearestZone;
    data['pickupPreference'] = this._pickupPreference;
    data['socialLink'] = this._socialLink;
    data['paymentMethod'] = this._paymentMethod;
    data['paymentmode'] = this._paymentmode;
    data['withdrawal'] = this._withdrawal;
    data['nameOfBank'] = this._nameOfBank;
    data['bankBranch'] = this._bankBranch;
    data['bankAcHolder'] = this._bankAcHolder;
    data['bankAcNo'] = this._bankAcNo;
    data['bkashNumber'] = this._bkashNumber;
    data['roketNumber'] = this._roketNumber;
    data['nogodNumber'] = this._nogodNumber;
    data['balance'] = this._balance;
    data['password'] = this._password;
    data['passwordReset'] = this._passwordReset;
    data['logo'] = this._logo;
    data['agree'] = this._agree;
    data['verify'] = this._verify;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
