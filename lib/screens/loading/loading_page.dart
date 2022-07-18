import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
            child: Lottie.asset('assets/lottie/loading.json'),
          )),
        ],
      ),
    );
  }
}
