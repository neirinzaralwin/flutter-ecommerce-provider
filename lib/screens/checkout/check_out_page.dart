import 'package:badges/badges.dart';
import 'package:ecommerce_app/components/widgets.dart';
import 'package:ecommerce_app/providers/shop_card_list.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

enum paymentMethods { KBZpay, WaveMoney }

enum deliveryMethods { Delivery, Pickup }

class _CheckOutPageState extends State<CheckOutPage> {
  paymentMethods? _payment = paymentMethods.KBZpay;
  deliveryMethods? _buymethod = deliveryMethods.Delivery;

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ShopCardListState>().productList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 20.0,
            color: iconColor,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: iconColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText('Payment'),
              SizedBox(height: 20),
              SubTitleText('Payment method'),
              SizedBox(height: 20),
              // Payment Method
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/icons/kbzpay.png'),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'KBZ Pay',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      leading: Radio<paymentMethods>(
                        activeColor: Colors.orange,
                        value: paymentMethods.KBZpay,
                        groupValue: _payment,
                        onChanged: (paymentMethods? v) {
                          setState(() {
                            _payment = v;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 70, right: 30),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/icons/wavepay.png'),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Wave Pay',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      leading: Radio<paymentMethods>(
                        activeColor: Colors.orange,
                        value: paymentMethods.WaveMoney,
                        groupValue: _payment,
                        onChanged: (paymentMethods? v) {
                          setState(() {
                            _payment = v;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SubTitleText('Delivery method'),
              SizedBox(height: 20),
              // Delivery Method
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    ListTile(
                      title: Row(
                        children: [
                          Text(
                            'Door Delivery',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      leading: Radio<deliveryMethods>(
                        activeColor: Colors.orange,
                        value: deliveryMethods.Delivery,
                        groupValue: _buymethod,
                        onChanged: (deliveryMethods? v) {
                          setState(() {
                            _buymethod = v;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 70, right: 30),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Text(
                            'Pick up',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      leading: Radio<deliveryMethods>(
                        activeColor: Colors.orange,
                        value: deliveryMethods.Pickup,
                        groupValue: _buymethod,
                        onChanged: (deliveryMethods? v) {
                          setState(() {
                            _buymethod = v;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Total
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubTitleText('Total'),
                    Text(
                      '24000',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: Dimensions.detailPageBottomHeight,
        padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
        decoration: BoxDecoration(
            color: scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Expanded(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: primaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Proceed to payment',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                ],
              )),
        ),
      ),
    );
  }
}
