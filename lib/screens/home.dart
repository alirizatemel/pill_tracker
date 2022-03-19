import 'package:flutter/material.dart';
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
  late DateTime _selectedDate;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  Future<void> _addNewAlarm(
      String aName, String aTime, String pillId, String weekDays) async {
    final newAlarm = AlarmItem(
      name: aName,
      time: aTime,
      pillId: pillId,
      weekDays: weekDays,
      id: DateTime.now().toString(),
    );
    await Provider.of<Alarm>(this.context, listen: false).addAlarm(newAlarm);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Alarm>(this.context).fetchAndSetAlarms().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _startAddNewAlarm(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewAlarm(_addNewAlarm),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteAlarm(String id) {
    Provider.of<Alarm>(this.context, listen: false).deleteAlarm(id);
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(Duration(days: 5));
  }

  @override
  Widget build(BuildContext context) {
    final alarmData = Provider.of<Alarm>(context).alarms;
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewAlarm(context),
      ),
      body: alarmData.isEmpty
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
                    setState(() {
                      _selectedDate = date!;
                    });
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
                          alarmData[index].name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(alarmData[index].time),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => _deleteAlarm(alarmData[index].id),
                        ),
                      ),
                    );
                  },
                  itemCount: alarmData.length,
                ),
                
              ],
            ),
    );
  }
}
