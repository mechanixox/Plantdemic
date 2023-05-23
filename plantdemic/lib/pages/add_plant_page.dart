import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../classes/plant.dart';

class AddPlantPage extends StatefulWidget {
  final Plant plant;
  const AddPlantPage({super.key, required this.plant});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  // create TextEditingController for text input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  // track if the text fields are empty
  bool isNameEmpty = false;
  bool isCostEmpty = false;
  bool isPriceEmpty = false;
  bool isQuantityEmpty = false;

  // control the visibility and opacity of the warning icon
  bool showWarningIcon = false;

  @override
  void dispose() {
    // dispose of the text editing controllers when the widget is disposed
    nameController.dispose();
    costController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void addToInventory() {
    String name = nameController.text;
    String cost = costController.text;
    String price = priceController.text;
    String quantity = quantityController.text;
    String imagePath = 'assets/icons/plant.png';

    // Reset the boolean variables
    isNameEmpty = false;
    isCostEmpty = false;
    isPriceEmpty = false;
    isQuantityEmpty = false;

    // Check if any text field is empty
    if (name.isEmpty) {
      isNameEmpty = true;
    }
    if (cost.isEmpty) {
      isCostEmpty = true;
    }
    if (price.isEmpty) {
      isPriceEmpty = true;
    }
    if (quantity.isEmpty) {
      isQuantityEmpty = true;
    }

    // If any field is empty, show the warning icon and dialog box
    if (isNameEmpty || isCostEmpty || isPriceEmpty || isQuantityEmpty) {
      setState(() {
        showWarningIcon = true;
      });
      if (isNameEmpty && showWarningIcon) {
        fillFields(widget.plant);
      }
      // Blink the warning icon several times
      Timer.periodic(Duration(milliseconds: 300), (timer) {
        setState(() {
          showWarningIcon = !showWarningIcon;
        });

        // Stop blinking after a certain number of times
        if (timer.tick >= 5) {
          setState(() {
            showWarningIcon = false;
          });
          timer.cancel();
        }
      });

      return;
    }

    // Create a new Plant object with the entered values
    Plant newPlant = Plant(
      name: name,
      cost: cost,
      price: price,
      quantity: quantity,
      imagePath: imagePath,
    );

    // Pass the new plant back to the previous screen
    Navigator.pop(context, newPlant);
  }

  void fillFields(Plant plant) {
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
                                      controller: nameController,
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
                                      controller: costController,
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
                                      controller: priceController,
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
                                      controller: quantityController,
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
