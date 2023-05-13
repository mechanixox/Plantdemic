import 'package:flutter/material.dart';

import '../deliveryTab.dart';

class UserDelivery extends StatefulWidget {
  const UserDelivery({super.key});

  @override
  State<UserDelivery> createState() => _UserDeliverState();
}

class _UserDeliverState extends State<UserDelivery> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Delivery'),
    );
  }
}
