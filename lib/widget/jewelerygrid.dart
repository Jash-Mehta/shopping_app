import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/productdata.dart';
import 'package:http/http.dart' as http;

class JeweleryGrid extends StatefulWidget {
  JeweleryGrid({Key? key}) : super(key: key);

  @override
  State<JeweleryGrid> createState() => _JeweleryGridState();
}

class _JeweleryGridState extends State<JeweleryGrid> {
List<ProductData> _iteam = [];
 @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = size.width / 2;
    return 
    FutureBuilder(
        future: getjewelerydata(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: _iteam.length,
                padding: const EdgeInsets.all(5.0),
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
                    Card(
                      elevation: 30.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          article.image,
                          fit: BoxFit.fill,
                          height: 250.0,
                          width: 320.0,
                        ),
                      ),
                    ),
                    ListTile(
                        title: Text(
                          article.title,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(Icons.favorite))
                  ]);
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

//! #-------------Fetching Jewelery ProductAPI-------------------#
  Future getjewelerydata() async {
    var client = http.Client();
    var response =
        await client.get(Uri.parse('https://fakestoreapi.com/products/category/jewelery'));
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