import 'package:flutter/material.dart';
import 'package:style_sphere/models/products.dart';
import 'package:style_sphere/repositories/product_repository.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  final ProductRepository productRepository = ProductRepository();

  Future<void> saveProduct() async {
    // Validate inputs
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter product name')),
      );
      return;
    }

    // Create Product object from form data
    final product = Product(
      imageUrl: imageUrlController.text,
      name: nameController.text,
      description: descriptionController.text,
      price: double.tryParse(priceController.text) ?? 0,
      rating: double.tryParse(ratingController.text) ?? 0,
      category: categoryController.text,
      stock: int.tryParse(stockController.text) ?? 0,
      discount: int.tryParse(discountController.text) ?? 0,
    );

    final productId = await productRepository.addProduct(product);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product added successfully! ID: $productId')),
    );

    clearFields();
  }

  void clearFields() {
    nameController.clear();
    priceController.clear();
    imageUrlController.clear();
    categoryController.clear();
    descriptionController.clear();
    discountController.clear();
    stockController.clear();
    ratingController.clear();
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType type = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(labelText: label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField('Name', nameController),
              buildTextField(
                'Price',
                priceController,
                type: TextInputType.number,
              ),
              buildTextField('Image URL', imageUrlController),
              buildTextField('Category', categoryController),
              buildTextField('Description', descriptionController),
              buildTextField(
                'Discount (%)',
                discountController,
                type: TextInputType.number,
              ),
              buildTextField(
                'Stock',
                stockController,
                type: TextInputType.number,
              ),
              buildTextField(
                'Rating',
                ratingController,
                type: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveProduct,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    discountController.dispose();
    stockController.dispose();
    ratingController.dispose();
    super.dispose();
  }
}
