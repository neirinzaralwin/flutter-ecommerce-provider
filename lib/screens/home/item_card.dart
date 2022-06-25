import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final press;
  const ItemCard({
    Key? key,
    required this.product,
    Function? this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String price = product.price.toString();

    return Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: InkWell(
          onTap: press,
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: secondaryColor1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          product.image,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(child: Text(product.title)),
                      const SizedBox(height: 8.0),
                      Center(
                          child: Text(
                        '$price Ks',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}


// Container(
//           width: double.infinity,
//           height: 500,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(
//                   product.image,
//                 ),
//                 fit: BoxFit.cover),
//             borderRadius: const BorderRadius.all(Radius.circular(15)),
//           ),
//         ),
