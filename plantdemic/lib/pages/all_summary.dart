import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  /*void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }*/

  DateTime? _selectedDate;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  Map<String, List> mySelectedEvents = {};
  final titleController = TextEditingController();
  final profitController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadPreviousEvents();
  }

  loadPreviousEvents() {
    mySelectedEvents = {
      "2022-09-13": [
        {"eventDescp": "11", "eventTitle": "111"},
        {"eventDescp": "22", "eventTitle": "22"}
      ],
      "2022-09-30": [
        {"eventDescp": "22", "eventTitle": "22"}
      ],
      "2022-09-20": [
        {"eventTitle": "ss", "eventDescp": "ss"}
      ]
    };
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add plant to list',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Plant name',
              ),
            ),
            TextField(
              controller: profitController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Profit'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              if (titleController.text.isEmpty &&
                  profitController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                //Navigator.pop(context);
                return;
              } else {
                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      "eventTitle": titleController.text,
                      "eventDescp": profitController.text,
                    });
                  } else {
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        "eventTitle": titleController.text,
                        "eventDescp": profitController.text,
                      }
                    ];
                  }
                });

                titleController.clear();
                profitController.clear();
                Navigator.pop(context);
                return;
              }
            },
          )
        ],
      ),
    );
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    String getMonthProfit() {
      // Logic to calculate the profit for the selected month
      // Replace with your own implementation
      return '₱1,500';
    }

    return Consumer<Plantdemic>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              '  Detailed summary',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 236, 241, 236),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0, top: 10),
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
                  padding: const EdgeInsets.only(top: 10.0, left: 0, right: 0),
                  child: TableCalendar(
                    calendarFormat: _calendarFormat,
                    locale: "en_US",
                    rowHeight: 50,
                    daysOfWeekHeight: 40,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      decoration: BoxDecoration(
                        color: Colors.green.shade100.withOpacity(0.5),
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      rowDecoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(2),
                            bottomRight: Radius.circular(2),
                          )),
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
                      titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      titleCentered: true,
                      decoration: BoxDecoration(
                        color: Colors.green.shade400,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    availableGestures: AvailableGestures.all,
                    focusedDay: today,
                    firstDay: DateTime.utc(2023, 01, 01),
                    lastDay: DateTime.utc(2030, 12, 30),
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDate, selectedDay)) {
                        setState(() {
                          _selectedDate = selectedDay;
                          today = focusedDay;
                        });
                      }
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDate, day);
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      today = focusedDay;
                    },
                    eventLoader: _listOfDayEvents,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${DateFormat('MMMM').format(today)} profit: ${getMonthProfit()}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey.shade400.withOpacity(0.8),
                ),
              ),
              if (_selectedDate != null)
                ..._listOfDayEvents(_selectedDate!).map(
                  (myEvents) => ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Image.asset(
                        'assets/icons/02peso-currency.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    title: Text('Plant name: ${myEvents['eventTitle']}'),
                    subtitle: Text('Profit: ${myEvents['eventDescp']}'),
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddEventDialog(),
          elevation: 0,
          // shape:  CircleBorder(),
          backgroundColor: Colors.green.shade400,
          label: const Text(
            'Add',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
