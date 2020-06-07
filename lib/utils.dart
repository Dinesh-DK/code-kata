import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Product {
  final String title, type, desc, img, element;
  final num height, width, cost, rating;

  Product(this.title, this.type, this.desc, this.img, this.height, this.width,
      this.cost, this.rating,[this.element = 'No  details found']);

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      json['title'],
      json['type'],
      json['description'],
      json['filename'],
      json['height'],
      json['width'],
      json['price'],
      json['rating'],
      json.toString()
    );
  }

  @override
  String toString() {
    String result = '';
    element.substring(1,element.length-1).split(',').forEach((e) {result += '$e \n\n';});
    return result;
  }
}

void populateProductList(List<Product> productList, Response response) {
  productList.clear();
  final List<Map<dynamic, dynamic>> jsonList =
      (json.decode(response.body).cast<Map<String, dynamic>>()).toList();
  jsonList.forEach((element) {
    productList.add(Product.fromMap(element));
  });
}

Widget getListView(List<Product> list) {
  return list.isEmpty
      ? Center(child: Text('No items found'))
      : ListView.builder(
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(list[index].title),
                subtitle: Text('rating: ' +
                    list[index].rating.toString() +
                    '/5 \t\tcategory: ' +
                    list[index].type),
                onTap: () {
                  onTapItem(list[index], context);
                });
          });
}

void onTapItem(Product product, BuildContext context) {
  print('${product.title} is opened');
  Navigator.push(
      context, MaterialPageRoute<dynamic>(
      fullscreenDialog: false,
      builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: Text(product.title)),
            body: Container(child: Text(product.toString())),
          );
      }));
}
