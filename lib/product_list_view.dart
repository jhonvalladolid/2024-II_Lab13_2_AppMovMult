import 'package:flutter/material.dart';
import 'product_database.dart';
import 'product.dart';
import 'product_detail_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ProductDatabase productDatabase = ProductDatabase.instance;

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    refreshProducts();
  }

  refreshProducts() async {
    final productList = await productDatabase.readAll();
    setState(() {
      products = productList;
    });
  }

  goToProductDetailView({int? id}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductDetailView(productId: id)),
    );
    refreshProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Productos")),
      body: products.isEmpty
          ? const Center(child: Text("No hay productos disponibles"))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () => goToProductDetailView(id: product.id),
                  child: Card(
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text("\$${product.price} - ${product.stock} en stock"),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToProductDetailView,
        tooltip: 'Crear Producto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
