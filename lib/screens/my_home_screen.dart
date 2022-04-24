/*
* File : Custom Onboarding
* Version : 1.0.0
* */

import 'package:eshops/screens/products/product_add.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Text("Main home"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProductAdd()))
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
