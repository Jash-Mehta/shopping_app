import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/cart_list.dart';
import 'package:shopping_app/widget/jewelerygrid.dart';
import 'package:shopping_app/widget/productgrid.dart';

var filterindex;

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

enum ShoppingFilter { Electronics, Jewelery, Mensclothing, Womensclothing }

final List<String> _filters = <String>[];
bool filtertextcolor = false;

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Search...",
                            prefixIcon: Icon(CupertinoIcons.search),
                            filled: true,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.grey[300],
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => CartList()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Container(
                      height: 57.0,
                      width: 57.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Icon(CupertinoIcons.cart),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    ShoppingFilter.values.map((ShoppingFilter shoppingFilter) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 10.0),
                    child: FilterChip(
                      label: Text(
                        shoppingFilter.name,
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      checkmarkColor: Colors.black,
                      avatarBorder: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      side: const BorderSide(color: Colors.black),
                      selected: _filters.contains(shoppingFilter.name),
                      onSelected: (bool value) {
                        setState(() {
                          if (value) {
                            if (!_filters.contains(shoppingFilter.name)) {
                              print(shoppingFilter.index);
                              filterindex = shoppingFilter.index;
                              _filters.add(shoppingFilter.name);
                            }
                          } else {
                            _filters.removeWhere((String name) {
                              print(
                                shoppingFilter,
                              );
                              filtertextcolor = false;
                              return name == shoppingFilter.name;
                            });
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
                flex: 12,
                child: filterindex == 1 ? JeweleryGrid() : ProductGrid())
          ],
        ),
      ),
    );
  }
}
