import 'package:catalog_app/core/store.dart';
import 'package:catalog_app/models/cartModel.dart';
import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/widgets/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: camel_case_types
class addToCart extends StatelessWidget {
  final Item catalog;
  const addToCart({
    Key? key,
    required this.catalog,
  }) : super(key: key);

// ignore: camel_case_type
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    bool isInCart = _cart.items.contains(catalog) ?? false;
    return ElevatedButton(
      onPressed: () {
        if (!isInCart) {
          AddMutation(catalog);
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MyTheme.DarkBluishColor)),
      child: isInCart
          ? const Icon(
              Icons.done,
              color: Colors.white,
            )
          : const Icon(
              CupertinoIcons.cart_badge_plus,
              color: Colors.white,
            ),
    );
  }
}
