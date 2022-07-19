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

String dummyText =
    "When starting to craft your perfect product description, it’s important to determine the best format to use.Since some online shoppers only scan text on websites, it might be helpful to use bullet points that cover the most important product details. Bullet points should generally be used for specs (like dimensions) or short phrases (like features) so they are quick and easy to read.Unfortunately, bullet points aren’t always the best way to tell a product’s story and convince target customers that they are looking at a great deal. They can look cold and clinical on a page instead of engaging the shopper’s emotions or imagination.To avoid those common mistakes and pain points, use prose instead.By writing a paragraph (three or more sentences) or two about the product, retailers can set the scene and help the shopper realize why their life up to this point has been incomplete without it. It may seem daunting, but after some practice, it will become second nature and even (gasp!) fun.";
