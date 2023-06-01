import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../models/plant.dart';
//import '../classes/inventory.dart';

class AddPlantPage extends StatefulWidget {
  final Plant plant;
  const AddPlantPage({super.key, required this.plant});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  // create TextEditingController for text input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // track if the text fields are empty
  bool isNameEmpty = false;
  bool isCostEmpty = false;
  bool isPriceEmpty = false;
  bool isQuantityEmpty = false;

  // control the visibility and opacity of the warning icon
  bool showWarningIcon = false;
  Timer? warningIconTimer;

  @override
  void dispose() {
    // dispose of the text editing controllers when the widget is disposed
    _nameController.dispose();
    _costController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    warningIconTimer?.cancel();
    super.dispose();
  }

  /* bool checkIfPlantNameExists(String name) {
    PlantdemicInventory inventory = PlantdemicInventory();
    List<Plant> inventoryPlants = inventory.inventory;

    name = name
        .trim()
        .toLowerCase(); // Remove leading/trailing white spaces and convert to lowercase

    for (Plant plant in inventoryPlants) {
      if (plant.name.trim().toLowerCase() == name) {
        return true; // A plant with the same name already exists
      }
    }

    return false; // No plant with the same name found
  }*/

  void addToInventory() {
    String name = _nameController.text;
    String cost = _costController.text;
    String price = _priceController.text;
    String quantity = _quantityController.text;
    String imagePath = 'assets/icons/plant.png';

    bool isValid = true; // Track if all fields are valid

    if (name.isEmpty) {
      setState(() {
        isNameEmpty = true;
        isValid = false;
      });
    } else {
      setState(() {
        isNameEmpty = false;
      });
    }

    if (cost.isEmpty) {
      setState(() {
        isCostEmpty = true;
        isValid = false;
      });
    } else {
      setState(() {
        isCostEmpty = false;
      });
    }

    if (price.isEmpty) {
      setState(() {
        isPriceEmpty = true;
        isValid = false;
      });
    } else {
      setState(() {
        isPriceEmpty = false;
      });
    }

    if (quantity.isEmpty) {
      setState(() {
        isQuantityEmpty = true;
        isValid = false;
      });
    } else {
      setState(() {
        isQuantityEmpty = false;
      });
    }

    if (isValid) {
      int parsedQuantity = int.tryParse(quantity) ?? 0;
      double parsedPrice = double.tryParse(price) ?? 0;
      double parsedCost = double.tryParse(cost) ?? 0;

      if (parsedQuantity <= 0 ||
          parsedPrice <= 0 ||
          parsedCost <= 0 ||
          quantity.contains(RegExp(r'[^0-9]')) ||
          price.contains(RegExp(r'[^0-9]')) ||
          cost.contains(RegExp(r'[^0-9]'))) {
        restrictFields(widget.plant);
        // Show the warning icon and blink it
        setState(() {
          showWarningIcon = true;
        });

        Timer.periodic(Duration(milliseconds: 350), (timer) {
          if (!mounted) {
            timer.cancel();
            return;
          }
          setState(() {
            showWarningIcon = !showWarningIcon;
          });

          if (timer.tick >= 9) {
            setState(() {
              showWarningIcon = false;
            });
            timer.cancel();
          }
        });
      } else {
        // All fields are valid, create a new Plant object
        Plant newPlant = Plant(
          name: name,
          cost: cost,
          price: price,
          quantity: quantity,
          imagePath: imagePath,
        );

        // Pass the new plant back to the previous screen
        Navigator.pop(context, newPlant);

        // Add the new plant to the inventory
        /*Provider.of<PlantdemicInventory>(context, listen: false)
              .addToInventory(context,newPlant);*/
      }
    } else {
      fillFields(widget.plant);
      // Show the warning icon and blink it
      setState(() {
        showWarningIcon = true;
      });

      Timer.periodic(Duration(milliseconds: 350), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          showWarningIcon = !showWarningIcon;
        });

        if (timer.tick >= 9) {
          setState(() {
            showWarningIcon = false;
          });
          timer.cancel();
        }
      });
    }
  }

  void fillFields(Plant plant) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 2), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
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
                      'All fields must be filled!',
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

  void restrictFields(Plant plant) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 2), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
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
              height: MediaQuery.of(context).size.width / 4,
              width: MediaQuery.of(context).size.height / 6,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Column(
                      children: [
                        Text(
                          'Please enter a valid number',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        Text(
                          'greater than 0.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        //SizedBox(height: 5)
                      ],
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

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Color.fromRGBO(106, 136, 86, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    'Add plant to inventory',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 30), //add space below text
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 239, 239, 239),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30.0, left: 30, right: 30),
                      child: Form(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 2),
                              // ignore: sized_box_for_whitespace
                              child: Column(
                                children: [
                                  //
                                  //enter plant name box
                                  //
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    //height: 50,
                                    padding: EdgeInsets.only(
                                        left: 15, right: 20, top: 7, bottom: 7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10), //circular radius of add plant text field
                                        color:
                                            Color.fromARGB(255, 239, 239, 239),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 191, 191, 191),
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            offset: Offset(-4.0, -4.0),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                          ),
                                        ]),
                                    child: TextField(
                                      cursorColor: Colors.grey[800],
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixIcon: isNameEmpty
                                            ? AnimatedOpacity(
                                                opacity:
                                                    showWarningIcon ? 1.0 : 0.0,
                                                duration:
                                                    Duration(milliseconds: 100),
                                                child: Icon(
                                                  Icons.warning_rounded,
                                                  color: Colors.red.shade400,
                                                ),
                                              )
                                            : null,
                                        icon: Icon(
                                          Icons.energy_savings_leaf_outlined,
                                          color:
                                              Color.fromARGB(255, 84, 153, 86),
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Enter plant name',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      controller: _nameController,
                                    ),
                                  ),
                                  //
                                  // enter cost box
                                  //
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    //height: 50,
                                    padding: EdgeInsets.only(
                                        left: 15, right: 20, top: 7, bottom: 7),
                                    margin: EdgeInsets.only(top: 25),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(255, 239, 239, 239),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 191, 191, 191),
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            offset: Offset(-4.0, -4.0),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                          ),
                                        ]),
                                    child: TextField(
                                      cursorColor: Colors.grey[800],
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        suffixIcon: isCostEmpty
                                            ? AnimatedOpacity(
                                                opacity:
                                                    showWarningIcon ? 1.0 : 0.0,
                                                duration:
                                                    Duration(milliseconds: 100),
                                                child: Icon(
                                                  Icons.warning_rounded,
                                                  color: Colors.red.shade400,
                                                ),
                                              )
                                            : null,
                                        icon: Icon(
                                          Icons.money_outlined,
                                          color:
                                              Color.fromARGB(255, 84, 153, 86),
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Enter cost',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      controller: _costController,
                                    ),
                                  ),
                                  //
                                  //
                                  // enter amount box
                                  //
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    //height: 50,
                                    padding: EdgeInsets.only(
                                        left: 15, right: 20, top: 7, bottom: 7),
                                    margin: EdgeInsets.only(top: 25),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(255, 239, 239, 239),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 191, 191, 191),
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            offset: Offset(-4.0, -4.0),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                          ),
                                        ]),
                                    child: TextField(
                                      cursorColor: Colors.grey[800],
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        suffixIcon: isPriceEmpty
                                            ? AnimatedOpacity(
                                                opacity:
                                                    showWarningIcon ? 1.0 : 0.0,
                                                duration:
                                                    Duration(milliseconds: 100),
                                                child: Icon(
                                                  Icons.warning_rounded,
                                                  color: Colors.red.shade400,
                                                ),
                                              )
                                            : null,
                                        icon: Icon(
                                          Icons.attach_money_rounded,
                                          color:
                                              Color.fromARGB(255, 84, 153, 86),
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Enter price',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      controller: _priceController,
                                    ),
                                  ),
                                  //
                                  //  enter quantity box
                                  //
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    //height: 50,
                                    padding: EdgeInsets.only(
                                        left: 15, right: 20, top: 7, bottom: 7),
                                    margin: EdgeInsets.only(top: 25),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(255, 239, 239, 239),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 191, 191, 191),
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                          ),
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            offset: Offset(-4.0, -4.0),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                          ),
                                        ]),
                                    child: TextField(
                                      cursorColor: Colors.grey[800],
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        suffixIcon: isQuantityEmpty
                                            ? AnimatedOpacity(
                                                opacity:
                                                    showWarningIcon ? 1.0 : 0.0,
                                                duration:
                                                    Duration(milliseconds: 100),
                                                child: Icon(
                                                  Icons.warning_rounded,
                                                  color: Colors.red.shade400,
                                                ),
                                              )
                                            : null,
                                        icon: Icon(
                                          Icons.numbers_rounded,
                                          color:
                                              Color.fromARGB(255, 84, 153, 86),
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Enter quantity',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      controller: _quantityController,
                                    ),
                                  ),
                                  //
                                  //cancel and add button
                                  //
                                  //SizedBox(height: 180), // add space below text fields
                                  Padding(
                                    padding: const EdgeInsets.only(top: 100),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //
                                        //cancel
                                        //
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Stack(children: <Widget>[
                                            Positioned.fill(
                                                child: Container(
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: <Color>[
                                                    Color.fromRGBO(
                                                        204, 112, 88, 1),
                                                    Color.fromRGBO(
                                                        204, 119, 97, 1),
                                                    Color.fromRGBO(
                                                        224, 148, 129, 1),
                                                  ])),
                                            )),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                  '     Cancel     '),
                                            ),
                                          ]),
                                        ),
                                        SizedBox(width: 30),
                                        //
                                        //add button
                                        //
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Stack(children: <Widget>[
                                            Positioned.fill(
                                                child: Container(
                                              decoration: const BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: <Color>[
                                                    Color.fromRGBO(
                                                        127, 159, 88, 1),
                                                    Color.fromRGBO(
                                                        134, 164, 97, 1),
                                                    Color.fromRGBO(
                                                        157, 189, 117, 1),
                                                  ])),
                                            )),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              onPressed: () => addToInventory(),
                                              child:
                                                  const Text('   Add plant   '),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
