class AdminProduct {
  int? id;
  String name;
  int quantity;
  double price;
  String date;
  String desc;

  AdminProduct({
    this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.date,
    required this.desc,
  });

  // Convert Product object to Map for Sqflite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'date': date,
      'desc': desc,
    };
  }

  // Create a Product object from Map (retrieved from Sqflite)
  static AdminProduct fromMap(Map<String, dynamic> map) {
    return AdminProduct(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? 0.0,
      date: map['date'] ?? '',
      desc: map['desc'] ?? '',
    );
  }
}
