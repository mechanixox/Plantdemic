import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plantdemic/classes/inventory.dart';
import 'package:provider/provider.dart';

import '../classes/plant.dart';

class ManagePlantPage extends StatefulWidget {
  final Plant plant;
  const ManagePlantPage({super.key, required this.plant});

  @override
  State<ManagePlantPage> createState() => _ManagePlantPageState();
}

class _ManagePlantPageState extends State<ManagePlantPage> {
  //add to delivery (outgoing)
  void addToDelivery() {
    //add to delivery page
    Provider.of<PlantdemicInventory>(context, listen: false)
        .addToDelivery(widget.plant);
    //upon clicking sell button, direct user back to inventory page
    Navigator.pop(context);
    //feedback
    showDialog(
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.93),
          title: Column(
            children: [
              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              */
              SizedBox(height: 10),
              Icon(Icons.check_circle, size: 80, color: Colors.green),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
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
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 216, 248, 216),
        appBar: AppBar(
          title: Text(widget.plant.name,
              style: TextStyle(
                color: Colors.black,
              )),
          backgroundColor: Color.fromARGB(255, 216, 248, 216),
        ),
        body: Center(
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
                //TASK: display plant information
                //code here

                //TASK: option to edit plant information
                //code here

                //sell plant, will be added to outgoing
                const SizedBox(height: 30), //sized box gives space

                //Sell button
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(children: <Widget>[
                    Positioned.fill(
                        child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                        Color.fromRGBO(127, 159, 88, 1),
                        Color.fromRGBO(145, 177, 106, 1),
                        Color.fromRGBO(157, 189, 117, 1),
                      ])),
                    )),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () => addToDelivery(),
                      child: const Text('         Sell         '),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
