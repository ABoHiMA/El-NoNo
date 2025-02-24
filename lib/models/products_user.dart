class UserProduct {
  int? id;
  int? pID;
  String name;
  int quantity;
  double total;
  String note;
  String date;

  UserProduct({
    required this.id,
    required this.pID,
    required this.name,
    required this.quantity,
    required this.total,
    required this.note,
    required this.date,
  });

  // Convert Product object to Map for Sqflite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pID': pID,
      'name': name,
      'quantity': quantity,
      'total': total,
      'note': note,
      'date': date,
    };
  }

  // Create a Product object from Map (retrieved from Sqflite)
  static UserProduct fromMap(Map<String, dynamic> map) {
    return UserProduct(
      id: map['id'] ?? 0,
      pID: map['pID'] ?? 0,
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      total: map['total'] ?? 0.0,
      note: map['note'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
