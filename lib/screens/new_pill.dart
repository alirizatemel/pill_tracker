import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class NewPill extends StatefulWidget {
  static const routeName = '/pill';

  @override
  State<NewPill> createState() => _NewPillState();
}

class _NewPillState extends State<NewPill> {
  final _nameController=TextEditingController();
  final _qrCodeController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Drug Name'),
            ),
            Text(
              'Or',
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'SCAN QR CODE'),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {},
            ),
          ],
        ),
      );
  }
}
