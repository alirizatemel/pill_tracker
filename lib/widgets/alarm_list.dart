// import 'package:calendar_timeline/calendar_timeline.dart';
// import 'package:flutter/material.dart';

// import '../providers/alarm.dart';
// class AlarmList extends StatelessWidget {
  
// final List<AlarmItem> alarmData;

// AlarmList(this.alarmData);

//   @override
//   Widget build(BuildContext context) {
//     if(alarmData.isEmpty){
// return Column(
//                       children: <Widget>[
//                         Text(
//                           'No alarms added yet!',
//                           style: Theme.of(context).textTheme.headline6,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     );
//     }
//     else{
// return
//                       Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         CalendarTimeline(
//                           showYears: false,
//                           initialDate: _selectedDate,
//                           firstDate: DateTime.now(),
//                           lastDate: DateTime.now().add(Duration(days: 365)),
//                           onDateSelected: (date) {
//                             _getAlarms(date);
//                           },
//                           leftMargin: 10,
//                           monthColor: Colors.black,
//                           dayColor: Colors.purple,
//                           dayNameColor: Color(0xFF333A47),
//                           activeDayColor: Colors.black,
//                           activeBackgroundDayColor: Colors.redAccent[100],
//                           dotsColor: Color(0xFF333A47),
//                           // selectableDayPredicate: (date) => date.day != 23,
//                           locale: 'en',
//                         ),
//                         const SizedBox(height: 20),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           itemBuilder: (ctx, index) {
//                             return Card(
//                               elevation: 5,
//                               margin: const EdgeInsets.symmetric(
//                                 vertical: 8,
//                                 horizontal: 5,
//                               ),
//                               child: ListTile(
//                                 leading: const CircleAvatar(
//                                   radius: 30,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(6),
//                                     child: FittedBox(
//                                       child: Text('Pill Image'),
//                                     ),
//                                   ),
//                                 ),
//                                 title: Text(
//                                   AlarmItem.fromMap(snapshot.data[index]).name,
//                                   style: Theme.of(context).textTheme.headline6,
//                                 ),
//                                 subtitle: Text(AlarmItem.fromMap(snapshot.data[index]).time),
//                                 trailing: IconButton(
//                                   icon: const Icon(Icons.delete),
//                                   color: Theme.of(context).errorColor,
//                                   onPressed: () =>
//                                       _deleteAlarm(AlarmItem.fromMap(snapshot.data[index]).id),
//                                 ),
//                               ),
//                             );
//                           },
//                           itemCount: alarmData,
//                         ),
//                       ],
//                     );
//     }
//   }
// }