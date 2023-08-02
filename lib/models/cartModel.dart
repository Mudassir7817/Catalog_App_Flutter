import 'package:catalog_app/core/store.dart';
import 'package:catalog_app/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  // // ignore: unused_field
  // static final cartModel = CartModel._internal();
  // CartModel._internal();
  // factory CartModel() => cartModel;

  late CatalogModel _catalog;

  final List<int> _itemsids = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
  }

  List<Item> get items => _itemsids.map((id) => _catalog.getById(id)).toList();

  num get totalprice =>
      items.fold(0, (total, current) => total + current.price);
}

class AddMutation extends VxMutation<MyStore> {
  final Item items;

  AddMutation(this.items);
  @override
  perform() {
    store?.cart._itemsids.add(items.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item items;

  RemoveMutation(this.items);
  @override
  perform() {
    store?.cart._itemsids.remove(items.id);
  }
}
