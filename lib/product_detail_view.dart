import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'product_database.dart';
import 'product.dart';
import 'dart:io';

class ProductDetailView extends StatefulWidget {
  final int? productId;

  const ProductDetailView({super.key, this.productId});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ProductDatabase productDatabase = ProductDatabase.instance;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late String imagePath;

  bool isLoading = false;
  bool isNewProduct = false;
  late Product product;

  @override
  void initState() {
    super.initState();
    if (widget.productId == null) {
      isNewProduct = true;
    } else {
      refreshProduct();
    }

    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    stockController = TextEditingController();
    imagePath = '';
  }

  refreshProduct() async {
    final prod = await productDatabase.read(widget.productId!);
    setState(() {
      product = prod;
      nameController.text = product.name;
      descriptionController.text = product.description;
      priceController.text = product.price.toString();
      stockController.text = product.stock.toString();
      imagePath = product.image;
    });
  }

  createProduct() async {
    setState(() {
      isLoading = true;
    });

    final newProduct = Product(
      name: nameController.text,
      description: descriptionController.text,
      price: double.parse(priceController.text),
      stock: int.parse(stockController.text),
      image: imagePath,
    );

    if (isNewProduct) {
      await productDatabase.create(newProduct);
    } else {
      await productDatabase.update(newProduct.copy(id: product.id));
    }

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context);
  }

  deleteProduct() async {
    await productDatabase.delete(product.id!);
    Navigator.pop(context);
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // Seleccionamos imagen
    if (image != null) {
      setState(() {
        imagePath = image.path;  // Guardamos el path de la imagen seleccionada
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isNewProduct ? "Crear Producto" : "Editar Producto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nombre del Producto'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                  ),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Precio'),
                  ),
                  TextField(
                    controller: stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Stock'),
                  ),
                  SizedBox(height: 10),
                  imagePath.isEmpty
                      ? const Text('No hay imagen seleccionada')
                      : Image.file(File(imagePath), width: 100, height: 100),
                  TextButton(
                    onPressed: pickImage,
                    child: const Text('Seleccionar Imagen'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!isNewProduct)
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: deleteProduct,
                        ),
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: createProduct,
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
