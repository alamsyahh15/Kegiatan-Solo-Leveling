import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';

void main() {
  ShopifyConfig.setConfig(
      '1bca87d12653840dab54b627dd91d2e7', // Storefront API access token.
      'surepricebox.myshopify.com', // Store url.
      '2020-04'); // The Shopify Storefront API version.

  runApp(MaterialApp(
    home: SampleHome(),
  ));
}

class SampleHome extends StatefulWidget {
  @override
  _SampleHomeState createState() => _SampleHomeState();
}

class _SampleHomeState extends State<SampleHome> {
  ShopifyAuth auth = ShopifyAuth.instance;
  Future<ShopifyUser> signInUser() async {
    var res = await auth.signInWithEmailAndPassword(
        email: "muhamad.a.syah31@gmail.com", password: "Rename017");
    log("Res ${res.address}");
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
