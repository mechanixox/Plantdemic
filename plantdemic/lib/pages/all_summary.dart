import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/plantdemic.dart';

class AllSummary extends StatefulWidget {
  const AllSummary({super.key});

  @override
  State<AllSummary> createState() => _AllSummaryState();
}

class _AllSummaryState extends State<AllSummary> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return Consumer<Plantdemic>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Detailed summary',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.grey.shade600,
                size: 20,
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 236, 241, 236),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 236, 241, 236),
                Color.fromRGBO(235, 237, 238, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 15, right: 15),
                  child: TableCalendar(
                    locale: "en_US",
                    rowHeight: 50,
                    daysOfWeekHeight: 40,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      decoration: BoxDecoration(
                        color: Colors.green.shade100.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.green.shade300,
                        shape: BoxShape.circle,
                      ),
                      defaultDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      weekendDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      formatButtonVisible: false,
                      titleTextStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      titleCentered: true,
                    ),
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    focusedDay: today,
                    firstDay: DateTime.utc(2023, 01, 01),
                    lastDay: DateTime.utc(2030, 12, 30),
                    onDaySelected: _onDaySelected,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey.shade400.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
