// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/providers/bag_list.dart';
import 'package:ecommerce_app/providers/shop_card_list.dart';
import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

class TotalPriceState extends Equatable {
  final int total;
  TotalPriceState({
    required this.total,
  });

  @override
  List<Object> get props => [total];

  @override
  bool get stringify => true;

  TotalPriceState copyWith({
    int? total,
  }) {
    return TotalPriceState(
      total: total ?? this.total,
    );
  }
}

class TotalPrice extends StateNotifier<TotalPriceState> with LocatorMixin {
  TotalPrice() : super(TotalPriceState(total: 0));

  @override
  void update(Locator watch) {
    final priceInBag = watch<BagListState>().subTotal;
    final productList = watch<ShopCardListState>().productList;

    List<int> integerList = [];
    int result = 0;
    if (priceInBag.isNotEmpty) {
      // Convert Map List to Integer List
      integerList = priceInBag.values
          .toList()
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map<int>((e) {
        return int.parse(e);
      }).toList();

      for (var i = 0; i < priceInBag.length; i++) {
        result += integerList[i];
      }
    }

    if (productList.isEmpty) {
      result = 0;
    }

    state = state.copyWith(total: result);

    super.update(watch);
  }
}
