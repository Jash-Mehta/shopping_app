import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping_app/models/box.dart';
import 'package:shopping_app/models/cartmodel.dart';
import 'package:shopping_app/screens/cart_list.dart';

import '../models/productdata.dart';

class ProductDetail extends StatefulWidget {
  int id;
  String title;
  var price;
  String description;
  String image;
  var rating;
  int count;
  ProductDetail({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rating,
    required this.count,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<Cartmode> listofcartmode = [];

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      Hive.close();
      super.dispose();
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
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
                      child: const Icon(CupertinoIcons.back),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text(
                      "Product Detail",
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                      child: const Icon(CupertinoIcons.cart),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Card(
                elevation: 30.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * 0.48,
                    width: MediaQuery.of(context).size.width * 0.9,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 15.0),
                  child: Container(
                    height: 30.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 247, 104, 104),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: const Center(
                      child: Text(
                        "Save 20%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15.0, right: 10.0),
                      child: Icon(
                        CupertinoIcons.star_fill,
                        color: Color.fromARGB(255, 255, 208, 0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0, right: 20.0),
                      child: Text(
                        "${widget.rating.toString()}(${widget.count})",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    )
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 15.0),
              child: Text(
                "Information",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 15.0, bottom: 10.0, right: 10.0),
              child: Text(
                widget.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: SizedBox(
        width: 150.0,
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          // ignore: sort_child_properties_last
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add Cart",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              Text(
                "₹${widget.price.toString()}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0),
              ),
            ],
          ),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          onPressed: () {
            addCartdata(
                widget.title, widget.price, widget.image, widget.rating);

            // box.put('title', widget.title);
            // box.put('imagelink', widget.image);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartList()));
          },
        ),
      ),
    );
  }

  void addCartdata(String titles, var prices, String imagelinks, var ratings) {
    final cartdata = Cartmode()
      ..title = titles
      ..price = prices
      ..image = imagelinks
      ..rating = ratings;
    final box = Boxes.getTransactions();
    box.add(cartdata);
    // box.put('mykey', cartdata);
    print(box);
  }
}
