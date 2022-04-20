import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import './new_alarm.dart';
import '../providers/alarm.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //var alarmData = [];
  late DateTime _selectedDate;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  Future<void> _addNewAlarm(AlarmItem newAlarm) async {
    await Provider.of<Alarm>(this.context, listen: false).insert(newAlarm);
  }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     var today = DateTime.now();
  //     _getAlarms(today);
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  // void _getAlarms(date) {
  //   setState(() {
  //     _isLoading = true;
  //     _selectedDate = date;
  //   });
  //   Alarm.getDocuments().then((value) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }

  void _startAddNewAlarm(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewAlarm(_addNewAlarm),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteAlarm(mongo.ObjectId id) {}

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(Duration(days: 5));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Alarm>(context, listen: false).getDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Something went wrong, try again.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(title: const Text('Home')),
                drawer: AppDrawer(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () => _startAddNewAlarm(context),
                ),
                body: snapshot.hasData
                    ? Column(
                        children: <Widget>[
                          Text(
                            'No alarms added yet!',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CalendarTimeline(
                            showYears: false,
                            initialDate: _selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            onDateSelected: (date) {
                              // _getAlarms(date);
                            },
                            leftMargin: 10,
                            monthColor: Colors.black,
                            dayColor: Colors.purple,
                            dayNameColor: Color(0xFF333A47),
                            activeDayColor: Colors.black,
                            activeBackgroundDayColor: Colors.redAccent[100],
                            dotsColor: Color(0xFF333A47),
                            // selectableDayPredicate: (date) => date.day != 23,
                            locale: 'en',
                          ),
                          const SizedBox(height: 20),
                          Consumer<Alarm>(
                            builder: (ctx, alarmData, child) =>
                                ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return Card(
                                  elevation: 5,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 5,
                                  ),
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      radius: 30,
                                      child: Padding(
                                        padding: EdgeInsets.all(6),
                                        child: FittedBox(
                                          child: Text('Pill Image'),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      alarmData.alarms[index].name,
                                      //  alarmData[index].name,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    subtitle:
                                        Text(alarmData.alarms[index].time),
                                    trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Theme.of(context).errorColor,
                                        onPressed: () async {
                                          Provider.of<Alarm>(context,
                                                  listen: false)
                                              .delete(
                                                  alarmData.alarms[index].id);
                                        }),
                                  ),
                                );
                              },
                              itemCount: alarmData.alarms.length,
                            ),
                          ),
                        ],
                      ),
              );
            }
          }
        });
  }
}
