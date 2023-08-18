// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Item {
  String id;
  String name;
  String? quantity;
  Item({
    required this.id,
    required this.name,
   this.quantity,
  });


  Item copyWith({
    String? id,
    String? name,
    String? quantity,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Item(id: $id, name: $name, quantity: $quantity)';

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.quantity == quantity;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ quantity.hashCode;
 }
