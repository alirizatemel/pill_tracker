import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class NewPill extends StatefulWidget {
  final Function addPill;

  NewPill(this.addPill);

  @override
  State<NewPill> createState() => _NewPillState();
}

class _NewPillState extends State<NewPill> {
  final _nameController = TextEditingController();
  final _qrCodeController = TextEditingController();

  void _submitData() {
    if (_nameController.text.isEmpty) {
      return;
    }
    final enteredName = _nameController.text;
    final enteredQrCode = _qrCodeController.text;

    if (enteredName.isEmpty || enteredQrCode.isEmpty) {
      return;
    }

    widget.addPill(enteredName, enteredQrCode);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top:10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom+10
            ),
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
                style: ElevatedButton.styleFrom(primary: Colors.purple, onPrimary:  Colors.white),
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
