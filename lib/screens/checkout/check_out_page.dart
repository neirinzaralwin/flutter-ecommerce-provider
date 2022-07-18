import 'package:ecommerce_app/components/widgets.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.detailPageImageHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/test.png'),
                  ),
                ),
              )),
          // App Bar
          Positioned(
              top: 45,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  AppIcon(
                    icon: Icons.shopping_cart,
                  ),
                ],
              )),
          // Body
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.detailPageImageHeight - 20,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product Name',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                          Icons.numbers_outlined,
                          '10C4A89',
                          accentColor,
                          Colors.black.withOpacity(0.5),
                        ),
                        IconAndTextWidget(
                          Icons.timelapse,
                          '3 weeks ago',
                          Colors.blueGrey,
                          Colors.black.withOpacity(0.5),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Information',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(height: 20),
                  ]),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.detailPageBottomHeight,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
            color: lightBrown,
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
              Icon(
                Icons.remove,
                color: Colors.black.withOpacity(0.4),
              ),
              SizedBox(width: 10),
              Text(
                '0',
                style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.add,
                color: Colors.black.withOpacity(0.4),
              ),
            ]),
          ),
          Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: primaryColor),
              child: Row(
                children: [
                  Text(
                    '30000',
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
              ))
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
