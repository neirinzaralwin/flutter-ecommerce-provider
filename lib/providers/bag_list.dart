// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_app/providers/shop_card_list.dart';
import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

class BagListState extends Equatable {
  final Map myBag;
  final Map subTotal;

  BagListState({
    required this.myBag,
    required this.subTotal,
  });

  @override
  List<Object> get props => [myBag, subTotal];

  @override
  bool get stringify => true;

  BagListState copyWith({
    Map? myBag,
    Map? subTotal,
  }) {
    return BagListState(
      myBag: myBag ?? this.myBag,
      subTotal: subTotal ?? this.subTotal,
    );
  }
}

class BagList extends StateNotifier<BagListState> with LocatorMixin {
  BagList() : super(BagListState(myBag: {}, subTotal: {}));

  @override
  void update(Locator watch) {
    // summerize amount and price to display
    Map mybag = {};
    watch<ShopCardListState>().productList.forEach((element) {
      if (mybag.containsKey(element)) {
        mybag[element]++;
      } else {
        mybag[element] = 1;
      }
    });
    state = state.copyWith(myBag: mybag);

    // calculate price and amount per product
    Map subtotal = {};
    if (mybag.isNotEmpty) {
      for (int i = 0; i < mybag.length; i++) {
        subtotal[mybag.keys.elementAt(i)] =
            mybag.keys.elementAt(i).price * mybag.values.elementAt(i);
      }
      state = state.copyWith(subTotal: subtotal);
    }

    super.update(watch);
  }
}
