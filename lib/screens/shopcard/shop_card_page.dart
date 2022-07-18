import 'package:ecommerce_app/providers/bag_list.dart';
import 'package:ecommerce_app/providers/shop_card_list.dart';
import 'package:ecommerce_app/providers/total_price.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopCardPage extends StatefulWidget {
  const ShopCardPage({Key? key}) : super(key: key);

  @override
  State<ShopCardPage> createState() => _ShopCardPageState();
}

class _ShopCardPageState extends State<ShopCardPage> {
  Widget showBackground(int direction) {
    return Container(
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.delete,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<BagListState>().myBag.keys.toList();
    final amount = context.watch<BagListState>().myBag.values.toList();
    final subTotal = context.watch<BagListState>().subTotal.values.toList();

    return SafeArea(
      child: Scaffold(
        appBar: _appbar,
        body: Stack(
          children: [
            // -> Bottom Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total: ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${context.watch<TotalPriceState>().total}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                            Text(
                              ' MMK',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        FloatingActionButton.extended(
                          label: Text('Check Out'), // <-- Text
                          backgroundColor: primaryColor,
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            size: 24.0,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Dismissible(
                    key: ValueKey(products[index].id),
                    background: showBackground(0),
                    secondaryBackground: showBackground(1),
                    onDismissed: (_) {
                      context
                          .read<ShopCardList>()
                          .removeFromCard(products[index]);
                    },
                    confirmDismiss: (_) {
                      return showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Are you sure?'),
                            content: Text('Do you really want to delete?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text('NO'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text('YES'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: _customList(
                        products: products,
                        index: index,
                        amount: amount,
                        subTotal: subTotal),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  get _appbar {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          CupertinoIcons.back,
          color: Color(0xFF545D68),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'My Cart',
        style: TextStyle(
          fontFamily: 'Varela',
          fontSize: 20.0,
          color: Color(0xFF545D68),
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              context.read<ShopCardList>().deleteAll();
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}

class _customList extends StatelessWidget {
  final List products;
  final int index;
  final List amount;
  final List subTotal;
  const _customList(
      {Key? key,
      required this.products,
      required this.index,
      required this.amount,
      required this.subTotal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('${products[index].image}'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 8.0, 8.0),
                  child: Column(
                    children: [
                      Text(
                        '${products[index].title}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Text(
                              '${subTotal[index]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 20),
                            ),
                            Text(
                              ' MMK',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<ShopCardList>()
                              .addToCard(products[index], 1);
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.black38,
                          size: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${amount[index]}',
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<ShopCardList>()
                              .decreaseValue(products[index]);
                        },
                        child: Icon(
                          Icons.remove,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
