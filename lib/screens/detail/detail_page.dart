import 'package:counter_button/counter_button.dart';
import 'package:ecommerce_app/providers/shop_card_list.dart';
import 'package:ecommerce_app/utils/alert.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _counterValue = 1;

  @override
  Widget build(BuildContext context) {
    late double screenwidth;
    if (MediaQuery.of(context).size.width <
        MediaQuery.of(context).size.height) {
      screenwidth = MediaQuery.of(context).size.width;
    } else {
      screenwidth = MediaQuery.of(context).size.height;
    }

    return Material(
        child: Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      label: const Text(
                        'Add to bag',
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                      ), // <-- Text
                      backgroundColor: secondaryColor1,
                      icon: const Icon(
                        Icons.shopping_bag,
                        size: 20.0,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        context
                            .read<ShopCardList>()
                            .addToCard(widget.product, _counterValue);
                        showAlertDialog(
                            context, "State Changed", "Added to Card!");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: screenwidth,
                width: screenwidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Center(
                  child: Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CounterButton(
                      loading: false,
                      onChange: (int val) {
                        if (val >= 0) {
                          setState(() {
                            _counterValue = val;
                          });
                        }
                      },
                      count: _counterValue,
                      countColor: primaryColor,
                      buttonColor: primaryColor,
                      progressColor: accentColor,
                    ),
                    Text(
                      '${widget.product.price.toString()} Ks',
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About the Product',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 15.0),
                child: Text(''),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
