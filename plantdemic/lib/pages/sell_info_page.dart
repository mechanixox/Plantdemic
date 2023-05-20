import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plantdemic/components/sell_info_tile.dart';
import 'package:provider/provider.dart';

import '../classes/inventory.dart';
import '../classes/plant.dart';

class SellInfoPage extends StatefulWidget {
  final Plant plant;
  const SellInfoPage({super.key, required this.plant});

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

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantdemicInventory>(
      builder: (context, plantdemicInventory, child) {
        return Scaffold(
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
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(
                    child: SafeArea(
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
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SellInfoTile(
                        plant: widget.plant,
                        editTapped: (context) {} //editPlantInfo(widget.plant),
                        ),
                    //
                    //
                    //
                    SizedBox(height: 200),
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
                                padding: const EdgeInsets.all(15),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () => addToDelivery(),
                              child: const Text('          Sell          '),
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
        );
      },
    );
  }
}
