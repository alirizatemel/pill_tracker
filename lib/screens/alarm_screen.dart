import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pill_tracker/screens/new_alarm.dart';
import 'package:provider/provider.dart';
import '../providers/alarm.dart';
import 'package:path/path.dart';
import '../widgets/app_drawer.dart';

class AlarmScreen extends StatefulWidget {
  static const routeName = '/alarm';
  // final Function deleteAlarm;


  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
    var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
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
    await Provider.of<Alarm>(this.context,listen: false).addAlarm(newAlarm);
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

  void _deleteAlarm(String id){
    Provider.of<Alarm>(this.context,listen: false).deleteAlarm(id);
  }

  @override
  Widget build(BuildContext context) {
    final alarmData=Provider.of<Alarm>(context).alarms;
    return Scaffold(
      appBar: AppBar(title: Text('Alarms')),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewAlarm(context),
      ),
      body: alarmData.isEmpty
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
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => _deleteAlarm(alarmData[index].id),
                    ),
                  ),
                );
              },
              itemCount: alarmData.length,
            ),
    );
  }
}
