import 'package:flutter/material.dart';
import 'package:plantdemic/classes/inventory.dart';
import 'package:plantdemic/pages/sell_info_page.dart';
import 'package:provider/provider.dart';

import '../classes/plant.dart';
import '../components/plant_info_tile.dart';
import 'package:plantdemic/textfield_utility/animated_textfield.dart';

class ManagePlantPage extends StatefulWidget {
  final Plant plant;
  const ManagePlantPage({Key? key, required this.plant}) : super(key: key);

  @override
  State<ManagePlantPage> createState() => _ManagePlantPageState();
}

class _ManagePlantPageState extends State<ManagePlantPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.plant.name;
    _priceController.text = widget.plant.price;
    _quantityController.text = widget.plant.quantity;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void editPlantInfo(Plant individualPlant) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade50.withOpacity(0.90),
          title: Row(
            children: [
              Icon(Icons.edit, color: Colors.grey.shade600),
              Text(
                ' Edit',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _nameController.clear();
                        _priceController.clear();
                        _quantityController.clear();
                      },
                      child: Text(
                        'Clear all',
                        style:
                            TextStyle(fontSize: 15, color: Colors.red.shade400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextField(
                label: "Name",
                suffix: Icon(
                  Icons.energy_savings_leaf_outlined,
                  size: 20,
                ),
                controller: _nameController,
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 10),
              AnimatedTextField(
                label: "Price",
                suffix: Icon(
                  Icons.attach_money_rounded,
                  size: 20,
                ),
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 10),
              AnimatedTextField(
                label: "Quantity",
                suffix: Icon(
                  Icons.numbers_rounded,
                  size: 20,
                ),
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputAction: TextInputAction.next,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _nameController.text = widget.plant.name;
                _priceController.text = widget.plant.price;
                _quantityController.text = widget.plant.quantity;
                Navigator.pop(context);
              }, // Cancel
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.red.shade400),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  individualPlant.name = _nameController.text;
                  individualPlant.price = _priceController.text;
                  individualPlant.quantity = _quantityController.text;
                });
                Provider.of<PlantdemicInventory>(context, listen: false)
                    .notifyListeners();
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade400),
              ),
            ),
          ],
        );
      },
    );
  }

  void navigateToSellInfoPage() {
    Plant sellPlant = Plant(
      name: widget.plant.name,
      cost: widget.plant.cost,
      price: widget.plant.price,
      quantity: widget.plant.quantity,
      imagePath: widget.plant.imagePath,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SellInfoPage(plant: sellPlant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantdemicInventory>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 241, 236),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              ' Plant information',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 236, 241, 236),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        //
        //
        //
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.plant.imagePath,
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 10),
                  //
                  // plant information tile
                  //
                  PlantInfoTile(
                    plant: widget.plant,
                    editTapped: (context) => editPlantInfo(widget.plant),
                  ),
                  //
                  // sell plant -> button
                  //
                  const SizedBox(height: 45), // space
                  Padding(
                    padding: const EdgeInsets.only(left: 90.0, right: 90),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color.fromRGBO(127, 159, 88, 1),
                                    Color.fromRGBO(145, 177, 106, 1),
                                    Color.fromRGBO(157, 189, 117, 1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 5, right: 5),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () => navigateToSellInfoPage(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(' Sell plant   ',
                                    style: TextStyle(fontSize: 18)),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
