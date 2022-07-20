// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/providers/total_price.dart';
import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:ecommerce_app/models/product.dart';

class ShopCardListState extends Equatable {
  final List<Product> productList;
  ShopCardListState({
    required this.productList,
  });

  @override
  List<Object> get props => [productList];

  @override
  bool get stringify => true;

  ShopCardListState copyWith({
    List<Product>? productList,
  }) {
    return ShopCardListState(
      productList: productList ?? this.productList,
    );
  }
}

class ShopCardList extends StateNotifier<ShopCardListState> {
  ShopCardList() : super(ShopCardListState(productList: []));

  void addToCard(Product product, int amount) {
    for (int i = 0; i < amount; i++) {
      state = state.copyWith(
          productList: [...state.productList, product]
            ..sort(((a, b) => a.title.compareTo(b.title))));
    }
  }

  void removeFromCard(Product removeProduct) {
    final newList = state.productList
        .where((Product e) => e.id != removeProduct.id)
        .toList();
    state = state.copyWith(productList: newList);
  }

  void decreaseValue(Product product) {
    List<Product> targetList =
        state.productList.where((Product p) => p.id == product.id).toList();

    if (targetList.isNotEmpty) {
      targetList.removeLast();
    }

    List<Product> detainedList =
        state.productList.where((Product p) => p.id != product.id).toList();
    final newList = targetList + detainedList;
    newList..sort(((a, b) => a.title.compareTo(b.title)));

    state = state.copyWith(productList: newList);
  }

  void deleteAll() {
    state = state.copyWith(productList: []);
  }
}
