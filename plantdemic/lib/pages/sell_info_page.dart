import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plantdemic/components/sell_info_tile.dart';
import 'package:provider/provider.dart';

import '../models/plantdemic.dart';
import '../models/plant.dart';
import '../textfield_utility/animated_textfield.dart';

class SellInfoPage extends StatefulWidget {
  final Plant plant;
  const SellInfoPage({Key? key, required this.plant}) : super(key: key);

  @override
  State<SellInfoPage> createState() => _SellInfoPageState();
}

class _SellInfoPageState extends State<SellInfoPage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _buyerController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  double price = 0;
  int quantity = 0;
  @override
  void initState() {
    super.initState();
    //_priceController.text = widget.plant.price;
    _buyerController.text = widget.plant.buyer ?? '';
    _dateController.text = widget.plant.deliveryDate ?? '';

    int initialQuantity = int.tryParse(widget.plant.quantity) ?? 0;
    setState(() {
      quantity = initialQuantity;
    });
    double initialPrice = double.tryParse(widget.plant.price) ?? 0.0;
    setState(() {
      price = initialPrice;
      _priceController.text = initialPrice.toString();
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _quantityController.dispose();
    _buyerController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // track if the text fields are empty
  bool isPriceEmpty = false;
  bool isQuantityEmpty = false;
  bool isBuyerEmpty = false;
  bool isDeliveryDateEmpty = false;
  //
  //
  //
  void addToDelivery() {
    String price = _priceController.text;
    String quantity = _quantityController.text;
    String buyer = _buyerController.text;
    String date = _dateController.text;

    isPriceEmpty = false;
    isQuantityEmpty = false;
    isBuyerEmpty = false;
    isDeliveryDateEmpty = false;

    // Check if any text field is empty

    if (price.isEmpty) {
      isPriceEmpty = true;
    }
    if (quantity.isEmpty) {
      isQuantityEmpty = true;
    }
    if (buyer.isEmpty) {
      isBuyerEmpty = true;
    }
    if (date.isEmpty) {
      isDeliveryDateEmpty = true;
    }

    if (isQuantityEmpty || isBuyerEmpty || isDeliveryDateEmpty) {
      fillFields(widget.plant);
      return;
    } else if (int.tryParse(quantity) == null ||
        int.tryParse(quantity)! > int.tryParse(widget.plant.quantity)! ||
        int.tryParse(quantity)! <= 0) {
      restrictQuantity(widget.plant);
      return;
    } else if (quantity.contains(RegExp(r'[^0-9]'))) {
      restrictQuantity(widget.plant);
      return;
    } else if (double.tryParse(price) == null ||
        double.tryParse(price)! <= 0 ||
        price.contains(RegExp(r'[^0-9\.]'))) {
      restrictPrice(widget.plant);
      return;
    }

    Provider.of<Plantdemic>(context, listen: false).addToDelivery(widget.plant);
    int sellQuantity = int.tryParse(_quantityController.text) ?? 0;
    Provider.of<Plantdemic>(context, listen: false)
        .decrementQuantity(widget.plant, sellQuantity);

    Navigator.popUntil(context, (route) => route.isFirst);

    showDialog(
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2), // Apply blur effect
          child: AlertDialog(
            backgroundColor:
                Color.fromARGB(255, 255, 255, 255).withOpacity(0.90),
            title: Column(
              children: [
                SizedBox(height: 0),
                Lottie.asset(
                  'assets/icons/send.json',
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Added to delivery!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }

  void fillFields(Plant plant) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2), // Apply blur effect
          child: AlertDialog(
            contentPadding: EdgeInsets.only(
                bottom: 14), // Remove the default content padding
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.green.shade50.withOpacity(0.80),
            content: Container(
              height: MediaQuery.of(context).size.width / 5,
              width: MediaQuery.of(context).size.height / 6,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      'All fields must be filled.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void restrictQuantity(Plant plant) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2), // Apply blur effect
          child: AlertDialog(
            contentPadding: EdgeInsets.only(
                bottom: 14), // Remove the default content padding
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.green.shade50.withOpacity(0.80),
            content: Container(
              height: MediaQuery.of(context).size.width / 5,
              width: MediaQuery.of(context).size.height / 6,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      'Please enter a valid quantity.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void restrictPrice(Plant plant) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2), // Apply blur effect
          child: AlertDialog(
            contentPadding: EdgeInsets.only(
                bottom: 14), // Remove the default content padding
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.green.shade50.withOpacity(0.80),
            content: Container(
              height: MediaQuery.of(context).size.width / 5,
              width: MediaQuery.of(context).size.height / 6,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      'Please enter a valid price.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void editSellPriceInfo(Plant individualPlant) {
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
                Provider.of<Plantdemic>(context, listen: false)
                    .notifyListeners();
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade500),
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
                ' Sell quantity',
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
                _quantityController.text = widget.plant.sellQuantity ?? '';

                Navigator.pop(context);
              }, // Cancel
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.red.shade400),
              ),
            ),
            TextButton(
              onPressed: () {
                //int quantity = int.parse(_quantityController.text);
                setState(() {
                  individualPlant.sellQuantity = _quantityController.text;
                });
                Provider.of<Plantdemic>(context, listen: false)
                    .notifyListeners();
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade500),
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
                _buyerController.text = widget.plant.buyer ?? '';

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
                Provider.of<Plantdemic>(context, listen: false)
                    .notifyListeners(); // Notify listeners of the changes
                Navigator.pop(context); // Done
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade500),
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
                  label: "Select date",
                  suffix: IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () {
                      selectDate();
                    },
                  ),
                  controller: _dateController,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _dateController.text = widget.plant.deliveryDate ?? '';
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
                Provider.of<Plantdemic>(context, listen: false)
                    .notifyListeners(); // Notify listeners of the changes
                Navigator.pop(context); // Done
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade500),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Plantdemic>(
      builder: (context, value, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 70,
              title: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 251, 255, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
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
              //backgroundColor: Color.fromRGBO(88, 129, 87, 1),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(226, 235, 240, 1),
                        Color.fromRGBO(207, 217, 223, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          widget.plant.name,
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
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
                    editPriceTapped: (context) =>
                        editSellPriceInfo(widget.plant),
                    editQuantityTapped: (context) =>
                        editSellQuantityInfo(widget.plant),
                    editBuyerTapped: (context) => editBuyerInfo(widget.plant),
                    editDateTapped: (context) => editDateInfo(widget.plant),
                  ),
                  //
                  // add to delivery button
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
                                    Color.fromARGB(255, 46, 166, 240),
                                    Color.fromARGB(255, 81, 171, 244),
                                    Color.fromARGB(255, 106, 184, 248),
                                    //Color.fromRGBO(120, 148, 165, 1),
                                    //Color.fromRGBO(120, 148, 165, 1),
                                    //Color.fromRGBO(207, 217, 223, 1),
                                    //Color.fromRGBO(226, 235, 240, 1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.only(top: 17, bottom: 17),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () => addToDelivery(),
                            child: const Text(
                              '          Add to delivery          ',
                              style: TextStyle(fontSize: 17),
                            ),
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
