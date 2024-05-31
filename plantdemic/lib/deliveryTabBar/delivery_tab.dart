import 'package:flutter/material.dart';
import 'package:plantdemic/deliveryTabBar/tab1.dart';
import 'package:plantdemic/deliveryTabBar/tab2.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 5),
              Container(
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 234, 234, 234),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: TabBar(
                        unselectedLabelColor:
                            Color.fromARGB(255, 148, 144, 144),
                        labelColor: Color.fromARGB(255, 255, 255, 255),
                        indicatorColor: Colors.white,
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                          color: Color.fromRGBO(124, 194, 134, 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        controller: tabController,
                        tabs: [
                          Tab(
                            child: Text(
                              'Incoming',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Outgoing',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Tab1(),
                    Tab2(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
