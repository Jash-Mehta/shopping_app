import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/screens/product_detail.dart';

import '../models/productdata.dart';
import 'package:http/http.dart' as http;

class ProductGrid extends StatefulWidget {
  ProductGrid({Key? key}) : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

List<ProductData> _iteam = [];

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 60) / 2;
    final double itemWidth = size.width / 2;
    return FutureBuilder(
        future: getdata(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: _iteam.length,
                padding: const EdgeInsets.all(4.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  var article = _iteam[index];
                  return Column(children: [
                    Stack(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductDetail(
                                        id: article.id,
                                        count: article.count,
                                        image: article.image,
                                        title: article.title,
                                        description: article.description,
                                        rating: article.rating,
                                        price: article.price,
                                      )));
                        },
                        child: Card(
                          elevation: 30.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              article.image,
                              fit: BoxFit.fill,
                              height: 240.0,
                              width: 230.0,
                            ),
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/pricetag.png',
                        height: 40.0,
                        width: 40.0,
                      ),
                      Positioned(
                        top: 15.0,
                        left: 10.5,
                        child: Text(
                          "₹${article.price.toString()}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
                    ListTile(
                        title: Text(
                          article.title,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Icons.favorite))
                  ]);
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

//! #-------------Fetching ProductAPI-------------------#
  Future getdata() async {
    var client = http.Client();
    var response =
        await client.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      List<ProductData> detaildata = [];

      var extractdata = jsonDecode(response.body) as List<dynamic>;

      extractdata.forEach((element) {
        detaildata.add(ProductData(
            id: element['id'],
            title: element['title'],
            price: element['price'],
            description: element['description'],
            image: element['image'],
            count: element['rating']['count'],
            rating: element['rating']['rate']));
      });

      _iteam = detaildata;
      return extractdata;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
