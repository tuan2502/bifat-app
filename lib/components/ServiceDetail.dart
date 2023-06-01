import 'package:flutter/material.dart';

//NHÁP LUÔN NHÉ!!!

class ServiceDetailPage extends StatefulWidget {
  final String imgUrl;
  final String serviceName;
  final double price;
  final int quantity;
  final String description;

  const ServiceDetailPage({
    Key? key,
    required this.imgUrl,
    required this.serviceName,
    required this.price,
    required this.quantity,
    required this.description,
  }) : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  late double currentPrice;
  int quantity = 1;
  bool isShippingSelected = false;
  String address = '';
  String selectShip = '';

  @override
  void initState() {
    super.initState();
    currentPrice = widget.price;
  }

  void increaseQuantity() {
    setState(() {
      quantity++;
      currentPrice = widget.price * quantity;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        currentPrice = widget.price * quantity;
      }
    });
  }

  void toggleShipping(bool? value) {
    setState(() {
      isShippingSelected = value ?? false;
    });
  }

  void submitForm() {
    // Implement logic for form submission
  }

  void showMaterialDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Material Dialog'),
          content: TextField(
            decoration: const InputDecoration(
              labelText: 'Material',
            ),
            onChanged: (value) {
              // Handle material input
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showShippingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Shipping Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Shipping'),
                items: <String>['1 Chiều', '2 Chiều'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectShip = newValue ?? '';
                  });
                },
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
                onChanged: (value) {
                  address = value;
                  // Handle address input
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Shipping nhó'),
              onPressed: () {
                // Handle shipping information submission
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.imgUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.serviceName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$${widget.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: decreaseQuantity,
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: increaseQuantity,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Shipping',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    title: const Text('Include Shipping'),
                    value: isShippingSelected,
                    onChanged: toggleShipping,
                  ),
                  if (isShippingSelected)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Shipping: $selectShip"),
                        Text('Address: $address'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: showShippingDialog,
                          child: const Text('Edit Shipping Information'),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  const Text(
                    'Material',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: showMaterialDialog,
                    child: const Text('Add Material'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: submitForm,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
