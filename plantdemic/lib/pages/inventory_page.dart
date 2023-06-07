import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plantdemic/models/plantdemic.dart';
import 'package:plantdemic/components/inventory_tile.dart';
import 'package:plantdemic/pages/sell_info_page.dart';
import 'package:provider/provider.dart';

import '../models/plant.dart';
import 'add_plant_page.dart';
import 'manage_plant_page.dart';

class UserInventory extends StatefulWidget {
  const UserInventory({Key? key}) : super(key: key);

  @override
  State<UserInventory> createState() => _UserInventoryState();
}

class _UserInventoryState extends State<UserInventory> {
  ImageProvider<Object>? selectedImage;
  List<Plant> searchResults = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSearchFocused = false;

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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
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
      searchResults = []; // Clear search results
      Provider.of<Plantdemic>(context, listen: false).sortInventory(
        Provider.of<Plantdemic>(context, listen: false).sortOption,
      );
    });
    FocusScope.of(context).unfocus();
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
                              border: InputBorder.none, // Disable underline
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
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 20, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Sort by: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 2, right: 5),
                      child: DropdownButton<String>(
                        value: value.sortOption,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10),
                        elevation: 1,
                        enableFeedback: true,
                        focusColor: Colors.transparent,
                        icon: Icon(Icons
                            .arrow_drop_down_outlined), // Add an arrow icon
                        iconSize: 24, // Adjust the icon size as desired
                        dropdownColor: Color.fromARGB(248, 246, 250, 251)
                            .withOpacity(0.95),
                        isDense: true,
                        items: <String>['None', 'Name', 'Price', 'Quantity']
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey
                                      .shade800, // Adjust the text size as desired
                                  decoration: TextDecoration
                                      .none, // Remove the underline
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            value.sortInventory(
                                newValue); // Call the sortInventory method with the selected sort option
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floating: true,
              snap: true,
              backgroundColor: Color.fromRGBO(242, 243, 245, 1),
              elevation: 0,
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
                      onTap: () => goToManagePlantPage(individualPlant),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () => goToManagePlantPage(individualPlant),
                      ),
                      deleteTapped: (context) =>
                          removeFromInventory(individualPlant),
                      sellTapped: (context) =>
                          navigateToSellInfoPage(individualPlant),
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
          onPressed: () => navigateToAddPlantPage(),
          backgroundColor: Colors.green.shade400,
          shape: CircleBorder(),
          child: Icon(Icons.add_rounded, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
