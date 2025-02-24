class DataAdmin {
  int nID;
  String name;
  String userName;
  String pass;
  String userUserName;
  String userPass;
  int isReg;
  int isActivate;
  String activateKey;

  DataAdmin({
    required this.nID,
    required this.name,
    required this.userName,
    required this.pass,
    required this.userUserName,
    required this.userPass,
    required this.isReg,
    required this.isActivate,
    required this.activateKey,
  });

  // Convert DataAdmin object to Map for Sqflite
  Map<String, dynamic> toMap() {
    return {
      'nID': nID,
      'name': name,
      'userName': userName,
      'pass': pass,
      'userUserName': userUserName,
      'userPass': userPass,
      'isReg': isReg,
      'isActivate': isActivate,
      'activateKey': activateKey,
    };
  }

  static DataAdmin fromMap(Map<String, dynamic> map) {
    return DataAdmin(
      nID: map['nID'] ?? 0, // Provide a default value if null
      name: map['name'] ?? '', // Handle null values for strings
      userName: map['username'] ?? '', // Ensure strings don't get null
      pass: map['pass'] ?? '',
      userUserName: map['userUsername'] ?? '',
      userPass: map['userPass'] ?? '',
      isReg: map['isReg'] ?? 0, // Handle nulls for integers
      isActivate: map['isActivate'] ?? 0, // Handle nulls for integers
      activateKey: map['activateKey'] ?? '',
    );
  }
}
