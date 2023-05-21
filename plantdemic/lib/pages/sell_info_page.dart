import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plantdemic/components/sell_info_tile.dart';
import 'package:provider/provider.dart';

import '../classes/inventory.dart';
import '../classes/plant.dart';
import '../textfield_utility/animated_textfield.dart';

class SellInfoPage extends StatefulWidget {
  final Plant plant;
  const SellInfoPage({Key? key, required this.plant}) : super(key: key);

  @override
  State<SellInfoPage> createState() => _SellInfoPageState();
}

class _SellInfoPageState extends State<SellInfoPage> {
  void addToDelivery() {
    Provider.of<PlantdemicInventory>(context, listen: false)
        .addToDelivery(widget.plant);
    widget.plant.decrementQuantity();

    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.90),
          title: Column(
            children: [
              SizedBox(height: 5),
              Icon(Icons.check_circle, size: 80, color: Colors.green),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Added successfully!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(106, 136, 86, 1),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _buyerController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _priceController.text = widget.plant.price;
    _quantityController.text = widget.plant.quantity;
    _buyerController.text = widget.plant.buyer ?? '';
    _dateController.text = widget.plant.deliveryDate ?? '';
  }

  @override
  void dispose() {
    _priceController.dispose();
    _quantityController.dispose();
    _buyerController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void editSellInfo(Plant individualPlant) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade50.withOpacity(0.90),
          title: Row(
            children: [
              Icon(Icons.price_change_outlined, color: Colors.grey.shade600),
              Text(
                ' New price',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _priceController.clear();
                      },
                      child: Text(
                        ' Clear',
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
                label: "Price",
                suffix: null,
                controller: _priceController,
                keyboardType: TextInputType.number,
                inputAction: TextInputAction.next,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _priceController.text = widget.plant.price;

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
                  individualPlant.price = _priceController.text;
                });
                Provider.of<PlantdemicInventory>(context, listen: false)
                    .notifyListeners(); // Notify listeners of the changes
                Navigator.pop(context); // Done
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

  void editSellQuantityInfo(Plant individualPlant) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade50.withOpacity(0.90),
          title: Row(
            children: [
              Icon(Icons.numbers_outlined, color: Colors.grey.shade600),
              Text(
                ' Quantity',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _quantityController.clear();
                      },
                      child: Text(
                        ' Clear',
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
                label: "Quantity",
                suffix: null,
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputAction: TextInputAction.next,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
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
                  individualPlant.quantity = _quantityController.text;
                });
                Provider.of<PlantdemicInventory>(context, listen: false)
                    .notifyListeners(); // Notify listeners of the changes
                Navigator.pop(context); // Done
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

  void editBuyerInfo(Plant individualPlant) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade50.withOpacity(0.90),
          title: Row(
            children: [
              Icon(Icons.person_add_outlined, color: Colors.grey.shade600),
              Text(
                ' Buyer',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _buyerController.clear();
                      },
                      child: Text(
                        ' Clear',
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
                label: "Buyer's name",
                suffix: null,
                controller: _buyerController,
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.next,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _buyerController.text = widget.plant.buyer!;

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
                  individualPlant.buyer = _buyerController.text;
                });
                Provider.of<PlantdemicInventory>(context, listen: false)
                    .notifyListeners(); // Notify listeners of the changes
                Navigator.pop(context); // Done
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

  void editDateInfo(Plant individualPlant) {
    showDialog(
      context: context,
      builder: (context) {
        DateTime selectedDate = DateTime.now();

        Future<void> selectDate() async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2021), 
            lastDate: DateTime(2024),
          );
          if (picked != null && picked != selectedDate) {
            setState(() {
              selectedDate = picked;
              _dateController.text =
                  "${selectedDate.month}/${selectedDate.day}/${selectedDate.year}";
            });
          }
        }

        return AlertDialog(
          backgroundColor: Colors.green.shade50.withOpacity(0.90),
          title: Row(
            children: [
              Icon(Icons.calendar_today_outlined, color: Colors.grey.shade600),
              Text(
                ' Date',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _dateController.clear();
                      },
                      child: Text(
                        ' Clear',
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
              InkWell(
                onTap: () {
                  selectDate();
                },
                child: AnimatedTextField(
                  label: "MM/DD/YYYY",
                  suffix: IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () {
                      selectDate();
                    },
                  ),
                  controller: _dateController,
                  keyboardType: null,
                  inputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _dateController.text = widget.plant.deliveryDate!;
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
                  individualPlant.deliveryDate = _dateController.text;
                });
                Provider.of<PlantdemicInventory>(context, listen: false)
                    .notifyListeners(); // Notify listeners of the changes
                Navigator.pop(context); // Done
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

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantdemicInventory>(
      builder: (context, value, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 251, 255, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Provide sell information",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromRGBO(106, 136, 86, 1),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Center(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        widget.plant.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Image.asset(
                      width: 210,
                      height: 210,
                      //'assets/icons/earning.png',
                      widget.plant.imagePath),
                  //
                  // sell info tile
                  //
                  SizedBox(height: 30),
                  SellInfoTile(
                    plant: widget.plant,
                    editPriceTapped: (context) => editSellInfo(widget.plant),
                    editQuantityTapped: (context) =>
                        editSellQuantityInfo(widget.plant),
                    editBuyerTapped: (context) => editBuyerInfo(widget.plant),
                    editDateTapped: (context) => editDateInfo(widget.plant),
                  ),
                  //
                  // sell button
                  //
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50, bottom: 70),
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () => addToDelivery(),
                            child: const Text(
                                '          Add to delivery          '),
                          ),
                        ],
                      ),
                    ),
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
