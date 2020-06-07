import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Market'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Product> productList = <Product>[];

  Future<void> requestServer() async {
    print('requesting server');
    final http.Response resp = await http.get(
        'https://raw.githubusercontent.com/Dinesh-DK/code-kata/master/products.json');
    if (resp.statusCode == 200) {
      populateProductList(productList, resp);
      setState(() {    
      });
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: getListView(productList),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: requestServer,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
