import 'dart:io';

class Product {
  String _name;
  String _description;
  double _price;

  Product(this._name, this._description, this._price);

  String get name => _name;
  String get description => _description;
  double get price => _price;

  set name(String newName) {
    _name = newName;
  }

  set description(String newDescription) {
    _description = newDescription;
  }

  set price(double newPrice) {
    _price = newPrice;
  }

  void display() {
    print('Name: $_name');
    print('Description: $_description');
    print('Price: \$$_price');
  }
}

class ProductManager {
  final List<Product> _products = [];

  void addProduct() {
    stdout.write('Enter product name: ');
    String name = stdin.readLineSync() ?? '';

    stdout.write('Enter product description: ');
    String description = stdin.readLineSync() ?? '';

    stdout.write('Enter product price: ');
    double? price = double.tryParse(stdin.readLineSync() ?? '');

    if (price == null) {
      print('Invalid price.');
      return;
    }

    Product product = Product(name, description, price);
    _products.add(product);
    print('Product added.\n');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print('No products available.\n');
      return;
    }

    for (int i = 0; i < _products.length; i++) {
      _products[i].display();
    }
  }

  void viewsingleProduct() {
    stdout.write('Enter product ID to view: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');
    if (_isValidId(id)) {
      _products[id!].display();
    } else {
      print('Product not found.\n');
    }
  }

  void editProduct() {
    stdout.write('Enter product ID to edit: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');
    if (_isValidId(id)) {
      stdout.write('Enter new name: ');
      _products[id!].name = stdin.readLineSync() ?? '';

      stdout.write('Enter new description: ');
      _products[id].description = stdin.readLineSync() ?? '';

      stdout.write('Enter new price: ');
      double? price = double.tryParse(stdin.readLineSync() ?? '');
      if (price != null) {
        _products[id].price = price;
        print('Product updated.\n');
      } else {
        print('Invalid price.\n');
      }
    } else {
      print('Product not found.\n');
    }
  }

  void deleteProduct() {
    stdout.write('Enter product ID to delete: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');
    if (_isValidId(id)) {
      _products.removeAt(id!);
      print('Product deleted.\n');
    } else {
      print('Product not found.\n');
    }
  }

  bool _isValidId(int? id) {
    return id != null && id >= 0 && id < _products.length;
  }
}

void main() {
  final manager = ProductManager();
  bool running = true;

  while (running) {
    print('\n--- eCommerce Product Manager ---');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Single Product');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');
    stdout.write('Choose an option: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        manager.addProduct();
        break;
      case '2':
        manager.viewAllProducts();
        break;
      case '3':
        manager.viewsingleProduct();
        break;
      case '4':
        manager.editProduct();
        break;
      case '5':
        manager.deleteProduct();
        break;
      case '6':
        running = false;
        print('Exiting...');
        break;
      default:
        print('Invalid option.\n');
    }
  }
}
