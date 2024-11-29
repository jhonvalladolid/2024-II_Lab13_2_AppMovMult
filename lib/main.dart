import 'package:flutter/material.dart';
import 'product_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación de Productos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductListView(),
    );
  }
}
