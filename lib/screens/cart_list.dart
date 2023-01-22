import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shopping_app/models/cartmodel.dart';
import 'package:shopping_app/models/productdata.dart';

import '../models/box.dart';

class CartList extends StatefulWidget {
  CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

var title, imagelink, sum;
List totalprice = [];

class _CartListState extends State<CartList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<Box<Cartmode>>(
          valueListenable: Boxes.getTransactions().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<Cartmode>();
            print(data);
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (BuildContext context, int index) {
                totalprice.add(data[index].price);
                sum = totalprice.reduce((a, b) => a + b);

                return SafeArea(
                  child: SizedBox(
                    height: 180.0,
                    width: double.infinity,
                    child: Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.only(
                          top: 30.0, left: 20.0, right: 20.0, bottom: 20.0),
                      color: Colors.grey[350],
                      child: Row(
                        children: [
                          Card(
                            elevation: 20.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                data[index].image.toString(),
                                fit: BoxFit.fill,
                                height: 150.0,
                                width: 100.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 60.0,
                                width: 240.0,
                                child: Text(
                                  data[index].title.toString(),
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Row(children: [
                                Container(
                                  height: 30.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 15, 15, 15),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Center(
                                    child: Text(
                                      "₹ ${data[index].price.toString()}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Container(
                                    height: 30.0,
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 15, 15, 15),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: InkWell(
                                      onTap: () {
                                        totalprice.clear();
                                        box.delete(data[index].key);
                                      },
                                      child: const Icon(
                                        CupertinoIcons.cart_fill_badge_minus,
                                        color: Colors.white,
                                      ),
                                    )),
                              ])
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: SizedBox(
          width: 150.0,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            // ignore: sort_child_properties_last
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Total Price",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                Text(
                  "₹${sum}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0),
                ),
              ],
            ),
            shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {},
          ),
        ));
  }
}
