import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pill_tracker/screens/new_alarm.dart';
import 'package:provider/provider.dart';
import '../providers/alarm.dart';
import 'package:path/path.dart';
import '../widgets/app_drawer.dart';

class AlarmScreen extends StatefulWidget {
  static const routeName = '/alarm';
  final List<AlarmItem> alarms;
  // final Function deleteAlarm;

  AlarmScreen(this.alarms);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  Future<void> _addNewAlarm(
      String aName, String aTime, String pillId, String weekDays) async {
    
    final newAlarm = AlarmItem(
      name: aName,
      time: aTime,
      pillId: pillId,
      weekDays: weekDays,
      id: DateTime.now().toString(),
    );
    print(newAlarm);
    await Provider.of<Alarm>(this.context,listen: false).addAlarm(newAlarm);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alarms')),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewAlarm(context),
      ),
      body: widget.alarms.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No alarms added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${widget.alarms[index].name}'),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.alarms[index].name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(widget.alarms[index].time),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {},
                    ),
                  ),
                );
              },
              itemCount: widget.alarms.length,
            ),
    );
  }
}
