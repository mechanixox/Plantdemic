import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plantdemic/classes/inventory.dart';
import 'package:provider/provider.dart';

import '../classes/plant.dart';
import '../components/plant_info_tile.dart';

class ManagePlantPage extends StatefulWidget {
  final Plant plant;
  const ManagePlantPage({Key? key, required this.plant}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ManagePlantPageState createState() => _ManagePlantPageState();
}

class _ManagePlantPageState extends State<ManagePlantPage> {
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

  void editPlantInfo(Plant individualPlant) {}

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantdemicInventory>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 216, 248, 216),
        appBar: AppBar(
          title: Text(
            widget.plant.name,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 216, 248, 216),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.plant.imagePath,
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  PlantInfoTile(
                    plant: widget.plant,
                    editTapped: (context) => editPlantInfo(widget.plant),
                  ),
                  const SizedBox(height: 60),
                  ClipRRect(
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
                            padding: const EdgeInsets.all(15),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () => addToDelivery(),
                          child: const Text('         Sell         '),
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
    );
  }
}
