import 'package:flutter/material.dart';
import 'package:plantdemic/deliveryTab.dart';

class UserDelivery extends StatefulWidget {
  const UserDelivery({super.key});

  @override
  State<UserDelivery> createState() => _UserDeliverState();
}

class _UserDeliverState extends State<UserDelivery> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 25, bottom: 25, top: 20, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(106, 136, 86, 1),
              ),
            ),

            Text(
              'Track incoming and outgoing plants',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                color: Color.fromRGBO(142, 162, 129, 1),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),

            //below the delivery
            Expanded(
              child: TabBarPage(),
            )
          ],
        ),
      ),
    );
  }
}
