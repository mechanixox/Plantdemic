import 'package:flutter/material.dart';
import '../classes/plant.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  // Create TextEditingController for text input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the text editing controllers when the widget is disposed
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Plant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            ElevatedButton(
              onPressed: () {
                // Create a new Plant object with the entered information
                Plant newPlant = Plant(
                  name: nameController.text,
                  price: priceController.text,
                  quantity: quantityController.text,
                  imagePath: 'assets/icons/plant.png', // Set the default image path
                );
                // Navigate back to the inventory page and pass the new plant
                Navigator.pop(context, newPlant);
              },
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
