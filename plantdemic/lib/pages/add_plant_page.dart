import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import '../components/image_picker.dart';
import '../models/plant.dart';

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
  File? _imageFile;
  void addToInventory() {
    String name = _nameController.text;
    String cost = _costController.text;
    String price = _priceController.text;
    String quantity = _quantityController.text;
    File? selectedImage = _imageFile;
    String imagePath =
        _imageFile != null ? _imageFile!.path : 'assets/icons/peso.png';

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
          parsedCost < 0 ||
          (!cost.startsWith('0') && !cost.startsWith(RegExp(r'^[1-9]'))) ||
          cost.split('.').length > 2 ||
          quantity.contains(RegExp(r'[^0-9]')) ||
          price.contains(RegExp(r'[^0-9\.]')) ||
          cost.contains(RegExp(r'[^0-9\.]')) ||
          name.contains(RegExp(r'[^a-zA-z]'))) {
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
          selectedImage:
              selectedImage != null ? FileImage(selectedImage) : null,
        );

        // Pass the new plant back to the previous screen
        Navigator.pop(context, newPlant);
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
    List<String> invalidFields = [];
    String name = _nameController.text;
    String cost = _costController.text;
    String price = _priceController.text;
    String quantity = _quantityController.text;

    int parsedQuantity = int.tryParse(quantity) ?? 0;
    double parsedPrice = double.tryParse(price) ?? 0;
    double parsedCost = double.tryParse(cost) ?? 0;
    if (name.contains(RegExp(r'[^a-zA-z]'))) {
      invalidFields.add("name");
    }
    if (parsedQuantity <= 0 || quantity.contains(RegExp(r'[^0-9]'))) {
      invalidFields.add("quantity");
    }
    if (parsedPrice <= 0 || (price.contains(RegExp(r'[^0-9\.]')))) {
      invalidFields.add("price");
    }
    if (parsedCost < 0 ||
        (!cost.startsWith('0') && !cost.startsWith(RegExp(r'^[1-9]'))) ||
        cost.split('.').length > 2 ||
        cost.contains(RegExp(r'[^0-9\.]'))) {
      invalidFields.add("cost");
    }

    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return BackdropFilter(
            filter:
                ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2), // Apply blur effect
            child: AlertDialog(
              backgroundColor: Colors.green.shade50.withOpacity(0.90),
              contentPadding: EdgeInsets.only(
                  bottom: 20), // Remove the default content padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 11.0),
                child: Text(
                  'Invalid input',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),

              content: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Please enter a valid input \nfor ${invalidFields.join(", ")}.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              actions: [
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 239, 239),
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
                  color: Color.fromARGB(255, 239, 239, 239),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Select a photo",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ),
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(204, 252, 211, 1),
                      Color.fromRGBO(18, 206, 158, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Center(
                        child: Text(
                          'Add your plants',
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                //
                // Image picker
                //
                ImagePickerWidget(
                  onImageSelected: (File? selectedImage) {
                    setState(() {
                      widget.plant.selectedImage = selectedImage != null
                          ? FileImage(selectedImage)
                          : null;
                    });
                  },
                ),

                SizedBox(height: 20),
                //
                //enter plant name box
                //
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  //height: 50,
                  padding:
                      EdgeInsets.only(left: 15, right: 20, top: 7, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10), //circular radius of add plant text field
                      color: Color.fromARGB(255, 239, 239, 239),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 191, 191, 191),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
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
                              opacity: showWarningIcon ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 100),
                              child: Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade400,
                              ),
                            )
                          : null,
                      icon: Icon(
                        Icons.energy_savings_leaf_outlined,
                        color: Color.fromARGB(255, 84, 153, 86),
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
                  width: MediaQuery.of(context).size.width / 1.2,
                  //height: 50,
                  padding:
                      EdgeInsets.only(left: 15, right: 20, top: 7, bottom: 7),
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 239, 239, 239),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 191, 191, 191),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
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
                              opacity: showWarningIcon ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 100),
                              child: Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade400,
                              ),
                            )
                          : null,
                      icon: Icon(
                        Icons.money_outlined,
                        color: Color.fromARGB(255, 84, 153, 86),
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
                  width: MediaQuery.of(context).size.width / 1.2,
                  //height: 50,
                  padding:
                      EdgeInsets.only(left: 15, right: 20, top: 7, bottom: 7),
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 239, 239, 239),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 191, 191, 191),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
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
                              opacity: showWarningIcon ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 100),
                              child: Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade400,
                              ),
                            )
                          : null,
                      icon: Icon(
                        Icons.attach_money_rounded,
                        color: Color.fromARGB(255, 84, 153, 86),
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
                  width: MediaQuery.of(context).size.width / 1.2,
                  //height: 50,
                  padding:
                      EdgeInsets.only(left: 15, right: 20, top: 7, bottom: 7),
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 239, 239, 239),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 191, 191, 191),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
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
                              opacity: showWarningIcon ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 100),
                              child: Icon(
                                Icons.warning_rounded,
                                color: Colors.red.shade400,
                              ),
                            )
                          : null,
                      icon: Icon(
                        Icons.numbers_rounded,
                        color: Color.fromARGB(255, 84, 153, 86),
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
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      //cancel
                      //
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red.shade400,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.red.shade600,
                                padding: const EdgeInsets.all(15),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: const Text('     Cancel     '),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 30),
                      //
                      //add button
                      //
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: <Color>[
                                Color.fromRGBO(134, 164, 97, 1),
                                Color.fromRGBO(157, 189, 117, 1),
                              ])),
                            )),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.all(15),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () => addToInventory(),
                              child: const Text('   Add plant   '),
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
        ],
      ),
    );
  }
}
