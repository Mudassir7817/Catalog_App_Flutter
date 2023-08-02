// ignore: file_names
import 'dart:convert';
import 'package:catalog_app/core/store.dart';
import 'package:catalog_app/models/cartModel.dart';
import 'package:catalog_app/widgets/add_to_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:catalog_app/Pages/Home_Detail_Page.dart';
import 'package:catalog_app/utils/MyRoutes.dart';
import 'package:catalog_app/widgets/themes.dart';

import '../models/catalog.dart';

// ignore: camel_case_types
class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

// ignore: camel_case_types
class _homePageState extends State<homePage> {
  @override
  void initState() {
    super.initState();
    localData();
  }

  localData() async {
    final catalogJson =
        await rootBundle.loadString("assets/files/Catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((items) => Item.fromMap(items))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: MyTheme.creamColor,
        floatingActionButton: VxBuilder(
          mutations: const {RemoveMutation, AddMutation},
          builder: (context, store, status) => FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, MyRoutes.cartroute),
            backgroundColor: MyTheme.DarkBluishColor,
            child: const Icon(
              CupertinoIcons.cart,
              color: Colors.white,
            ),
          ).badge(
              color: Colors.indigoAccent,
              size: 18,
              count: _cart.items.length,
              textStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
            child: Container(
                padding: Vx.m32,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CatalogHeader(),
                      if (CatalogModel.items.isNotEmpty)
                        CatalogList().py16().expand()
                      else
                        const Center(child: CircularProgressIndicator())
                    ]))));
  }
}

class CatalogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl5.bold.color(MyTheme.DarkBluishColor).make(),
        "Trending Products".text.xl2.make()
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: CatalogModel.items.length,
        itemBuilder: (context, index) {
          final catalog = CatalogModel.items[index];
          return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeDetailPage(catalog: catalog))),
              child: CatalogItem(catalog: catalog));
        });
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(children: [
      Hero(
        tag: Key(catalog.id.toString()),
        child: Image.network(catalog.image)
            .box
            .rounded
            .p1
            .color(MyTheme.creamColor)
            .make()
            .p16()
            .w40(context),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.name.text.lg.bold.color(MyTheme.DarkBluishColor).make(),
            catalog.desc.text.textStyle(context.captionStyle).make(),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                "\$${catalog.price}".text.bold.make(),
                addToCart(catalog: catalog)
              ],
            )
          ],
        ),
      )
    ])).white.rounded.square(150).make().py12();
  }
}

// ignore: camel_case_types

