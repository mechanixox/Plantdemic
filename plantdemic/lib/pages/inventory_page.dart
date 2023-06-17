import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plantdemic/models/plantdemic.dart';
import 'package:plantdemic/components/inventory_tile.dart';
import 'package:plantdemic/pages/plant_info_page.dart';
import 'package:plantdemic/pages/sell_info_page.dart';
import 'package:provider/provider.dart';

import '../database/plantdemic_database.dart';
import '../models/plant.dart';
import 'add_plant_page.dart';

class UserInventory extends StatefulWidget {
  const UserInventory({Key? key}) : super(key: key);

  @override
  State<UserInventory> createState() => _UserInventoryState();
}

class _UserInventoryState extends State<UserInventory> {
  PlantdemicDatabase db = PlantdemicDatabase();
  List<Plant> inventoryPlants = [];
  ImageProvider<Object>? selectedImage;
  List<Plant> searchResults = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    fetchInventoryData();
    Provider.of<Plantdemic>(context, listen: false).prepareData();
    _scrollController.addListener(_handleScroll);
  }

  void fetchInventoryData() {
    inventoryPlants = db.readInventoryData();
  }

  void goToManagePlantPage(Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManagePlantPage(plant: plant),
      ),
    );
  }

  void navigateToAddPlantPage() {
    Plant newPlant = Plant(
      name: 'Default Plant',
      cost: '0',
      price: '0',
      quantity: '0',
      imagePath: 'assets/icons/plant.png',
      selectedImage: selectedImage,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlantPage(plant: newPlant),
      ),
    ).then((result) {
      if (result != null && result is Plant) {
        Provider.of<Plantdemic>(context, listen: false)
            .addToInventory(context, result);
      }
    });
  }

  void removeFromInventory(Plant plant) {
    Provider.of<Plantdemic>(context, listen: false).removeFromInventory(plant);
    setState(() {
      if (searchResults.contains(plant)) {
        searchResults.remove(plant);
      }
    });
  }

  void navigateToSellInfoPage(Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SellInfoPage(plant: plant)),
    );
  }

  void searchPlants(String query) {
    setState(() {
      String lowercaseQuery = query.toLowerCase();
      if (query.isEmpty) {
        searchResults = [];
      } else {
        searchResults = Provider.of<Plantdemic>(context, listen: false)
            .inventory
            .where((plant) => plant.name.toLowerCase().contains(lowercaseQuery))
            .toList();
      }
      Provider.of<Plantdemic>(context, listen: false).sortInventory(
          Provider.of<Plantdemic>(context, listen: false).sortOption);
    });
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection !=
        ScrollDirection.idle) {
      clearSearchField();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void clearSearchField() {
    setState(() {
      searchController.clear();
      _isSearchFocused = false;
      searchResults = []; // clear search results
      Provider.of<Plantdemic>(context, listen: false).sortInventory(
        Provider.of<Plantdemic>(context, listen: false).sortOption,
      );
    });
    FocusScope.of(context).unfocus();
  }

  String sortingOrder = 'Default';

  void _displayBottomSheet() {
    //clearSearchField();
    db.saveInventoryData(inventoryPlants);
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: Navigator.of(context),
    );

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      transitionAnimationController: animationController,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final animation = CurvedAnimation(
              parent: animationController,
              curve: Curves.easeInOut,
            ).drive(Tween<Offset>(
              begin: Offset(0, 1),
              end: Offset.zero,
            ));

            return SlideTransition(
              position: animation,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Provider.of<Plantdemic>(context, listen: false)
                                .sortInventory('Default');
                            setState(() {
                              sortingOrder =
                                  sortingOrder == 'Default' ? '' : 'Default';
                              db.saveInventoryData(inventoryPlants);
                            });
                            Navigator.pop(context);
                          },
                          leading: Icon(Icons.sort),
                          title: Text('Default'),
                        ),
                        ListTile(
                          onTap: () {
                            Provider.of<Plantdemic>(context, listen: false)
                                .sortInventory('Name');
                            setState(() {
                              sortingOrder =
                                  sortingOrder == 'Name' ? '' : 'Name';
                              db.saveInventoryData(inventoryPlants);
                            });
                            Navigator.pop(context);
                          },
                          leading: Icon(Icons.sort_by_alpha_outlined),
                          title: Text('Name'),
                          trailing: sortingOrder == 'Name'
                              ? RotationTransition(
                                  turns: Tween(begin: 0.5, end: 0.0)
                                      .animate(animationController),
                                  child: Icon(Icons.arrow_downward_outlined),
                                )
                              : null,
                        ),
                        ListTile(
                          onTap: () {
                            Provider.of<Plantdemic>(context, listen: false)
                                .sortInventory('Price');
                            setState(() {
                              sortingOrder =
                                  sortingOrder == 'Price' ? '' : 'Price';
                              db.saveInventoryData(inventoryPlants);
                            });
                            Navigator.pop(context);
                          },
                          leading: Icon(Icons.sell_outlined),
                          title: Text('Price'),
                          trailing: sortingOrder == 'Price'
                              ? RotationTransition(
                                  turns: Tween(begin: 0.5, end: 0.0)
                                      .animate(animationController),
                                  child: Icon(Icons.arrow_downward_outlined),
                                )
                              : null,
                        ),
                        ListTile(
                          onTap: () {
                            Provider.of<Plantdemic>(context, listen: false)
                                .sortInventory('Quantity');
                            setState(() {
                              sortingOrder =
                                  sortingOrder == 'Quantity' ? '' : 'Quantity';
                              db.saveInventoryData(inventoryPlants);
                            });
                            Navigator.pop(context);
                          },
                          leading: Icon(Icons.numbers_outlined),
                          title: Text('Quantity'),
                          trailing: sortingOrder == 'Quantity'
                              ? RotationTransition(
                                  turns: Tween(begin: 0.5, end: 0.0)
                                      .animate(animationController),
                                  child: Icon(Icons.arrow_downward_outlined),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Plantdemic>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromRGBO(242, 243, 245, 1),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              scrolledUnderElevation: 0,
              toolbarHeight: 70,
              title: Padding(
                padding: const EdgeInsets.only(
                    left: 3.0, right: 3.0, top: 2, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.90),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _isSearchFocused
                                ? Colors.transparent
                                : Colors.white.withOpacity(0.90),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            cursorColor: Colors.grey,
                            controller: searchController,
                            onChanged: (query) {
                              setState(() {
                                searchPlants(query.trim());
                                _isSearchFocused = query.isNotEmpty;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search plants',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(Icons.search_rounded),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isSearchFocused,
                        child: GestureDetector(
                          onTap: clearSearchField,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.grey.shade500,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floating: true,
              snap: true,
              backgroundColor: _isSearchFocused
                  ? Colors.transparent
                  : Color.fromRGBO(242, 243, 245, 1),
              elevation: 0,
            ),
            SliverAppBar(
              toolbarHeight: 40,
              floating: true,
              snap: true,
              backgroundColor: Color.fromRGBO(242, 243, 245, 1),
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 20, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _displayBottomSheet();
                        },
                        child: Icon(
                          Icons.sort,
                          size: 20,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _displayBottomSheet();
                        },
                        child: Text(
                          'Sort by: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 2, right: 5),
                      child: GestureDetector(
                        onTap: () {
                          _displayBottomSheet();
                        },
                        child: Row(
                          children: [
                            Text(
                              value.sortOption,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade800,
                                decoration: TextDecoration.none,
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  Plant individualPlant;
                  if (searchResults.isEmpty) {
                    individualPlant = value.inventory[index];
                  } else {
                    individualPlant = searchResults[index];
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: InventoryTile(
                      plant: individualPlant,
                      onTap: () {
                        goToManagePlantPage(individualPlant);
                        clearSearchField();
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () => goToManagePlantPage(individualPlant),
                      ),
                      deleteTapped: (context) =>
                          removeFromInventory(individualPlant),
                      sellTapped: (context) {
                        navigateToSellInfoPage(individualPlant);
                        clearSearchField();
                      },
                      selectedImage: individualPlant.selectedImage,
                    ),
                  );
                },
                childCount: searchResults.isEmpty
                    ? value.inventory.length
                    : searchResults.length,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToAddPlantPage();
            clearSearchField();
          },
          backgroundColor: Colors.green.shade400,
          shape: CircleBorder(),
          child: Icon(Icons.add_rounded, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
