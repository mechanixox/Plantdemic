import 'package:flutter/material.dart';
import 'package:plantdemic/classes/plant.dart';
import 'package:provider/provider.dart';

import '../classes/inventory.dart';
import '../components/delivery_info_tile.dart';

class ManageDeliveryPage extends StatefulWidget {
  final Plant plant;
  const ManageDeliveryPage({super.key, required this.plant});

  @override
  State<ManageDeliveryPage> createState() => _ManageDeliveryPageState();
}

class _ManageDeliveryPageState extends State<ManageDeliveryPage> {
  void addToRecords() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantdemicInventory>(
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
                      child: Icon(Icons.arrow_back_ios_new_rounded),
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
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Delivery information",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromARGB(255, 216, 248, 216),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Center(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Center(
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
                  SizedBox(height: 20),
                  Image.asset(
                      width: 150,
                      height: 150,
                      //'assets/icons/earning.png',
                      widget.plant.imagePath),
                  //
                  // sell info tile
                  //
                  SizedBox(height: 10),
                  DeliveryInfoTile(
                    plant: widget.plant,
                  ),
                  //
                  // sold button
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
                                  const EdgeInsets.only(top: 17, bottom: 17),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () => addToRecords(),
                            child: const Text(
                              '              Sold               ',
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
