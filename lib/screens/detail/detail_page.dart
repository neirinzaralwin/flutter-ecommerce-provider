import 'package:badges/badges.dart';
import 'package:ecommerce_app/components/widgets.dart';
import 'package:ecommerce_app/providers/shop_card_list.dart';
import 'package:ecommerce_app/screens/detail/expandable_text_widget.dart';
import 'package:ecommerce_app/utils/alert.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _counterValue = 1;

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ShopCardListState>().productList;

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        backgroundColor: Colors.white,
                        iconColor: primaryColor,
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'shopcard');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Badge(
                        position: BadgePosition.topEnd(top: -13, end: -12),
                        showBadge: (products.length > 0) ? true : false,
                        badgeContent: Text(
                          '${products.length}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: Color(0xFF545D68),
                          size: Dimensions.iconSize16 + 4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Name',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconAndTextWidget(
                              Icons.numbers_outlined,
                              '${widget.product.id}',
                              accentColor,
                              Colors.black.withOpacity(0.3),
                              FontWeight.normal,
                            ),
                            IconAndTextWidget(
                              Icons.price_change_outlined,
                              '${widget.product.price} MMK',
                              Colors.green,
                              Colors.black.withOpacity(0.6),
                              FontWeight.bold,
                            ),
                            IconAndTextWidget(
                              Icons.timelapse,
                              '3 weeks',
                              Colors.blueGrey,
                              Colors.black.withOpacity(0.3),
                              FontWeight.normal,
                            )
                          ],
                        ),
                      ]),
                ),
              ),
              pinned: true,
              backgroundColor: primaryColor,
              expandedHeight: Dimensions.detailPageImageHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  '${widget.product.image}',
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              )),
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Information',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child:
                    ExpandableTextWidget(text: '${widget.product.description}'),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.detailPageBottomHeight,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color: lightBrown.withOpacity(0.5),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // Counter
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Row(children: [
              InkWell(
                onTap: () {
                  if (_counterValue > 0) {
                    setState(() {
                      _counterValue--;
                    });
                  }
                },
                child: Icon(
                  Icons.remove,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              SizedBox(width: 10),
              Text(
                _counterValue.toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  setState(() {
                    _counterValue++;
                  });
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ]),
          ),
          InkWell(
            onTap: () {
              if (_counterValue > 0) {
                context
                    .read<ShopCardList>()
                    .addToCard(widget.product, _counterValue);
              } else {
                showAlertDialog(context, "Alert",
                    "You must have at least one item to add to shop cart", () {
                  Navigator.pop(context);
                });
              }
              setState(() {
                _counterValue = 0;
              });
            },
            child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryColor),
                child: Row(
                  children: [
                    Text(
                      (_counterValue * widget.product.price).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'mmk',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      ' | Add to cart',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )
        ]),
      ),
    );
  }
}

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  const AppIcon(
      {Key? key,
      required this.icon,
      this.backgroundColor = primaryColor,
      this.iconColor = Colors.white,
      this.size = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: Dimensions.iconSize16,
      ),
    );
  }
}
