// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String image;
  final String title;
  final String description;
  final int price;
  final int id;
  final int amount;
  const Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.amount,
  });

  @override
  List<Object> get props => [description, id];

  @override
  bool get stringify => true;

  Product copyWith({
    String? image,
    String? title,
    String? description,
    int? price,
    int? id,
    int? amount,
  }) {
    return Product(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }
}

List<Product> products = [
  Product(
      id: 1,
      title: "Product1",
      price: 3000,
      description: dummyText,
      image: "assets/images/product1.jpeg",
      amount: 0),
  Product(
      id: 2,
      title: "Product2",
      price: 8000,
      description: dummyText,
      image: "assets/images/product2.jpeg",
      amount: 0),
  Product(
    id: 3,
    title: "Product3",
    price: 9000,
    description: dummyText,
    image: "assets/images/product3.jpeg",
    amount: 0,
  ),
  Product(
    id: 4,
    title: "Product4",
    price: 4500,
    description: dummyText,
    image: "assets/images/product4.jpeg",
    amount: 0,
  ),
  Product(
    id: 5,
    title: "Product5",
    price: 6500,
    description: dummyText,
    image: "assets/images/product5.jpeg",
    amount: 0,
  ),
];

String dummyText = "Description...";
