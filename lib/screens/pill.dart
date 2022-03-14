import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pill.dart';
import '../widgets/app_drawer.dart';
import './new_pill.dart';

class PillScreen extends StatefulWidget {
  static const routeName = '/pill';

  final List<Pill> pills;
  PillScreen(this.pills);

  @override
  State<PillScreen> createState() => _PillScreenState();
}

class _PillScreenState extends State<PillScreen> {
  Future<void> _addNewPill(String name, String qrCode) async {
    final newPill = Pill(
      id: DateTime.now().toString(),
      name: name,
      qrCode: qrCode,
    );
    //http post
  }

  void _startAddNewPill(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewPill(_addNewPill),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pills')),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewPill(context),
      ),
      body: widget.pills.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No pills added yet!',
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
                          child: Text('\$${widget.pills[index].name}'),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.pills[index].name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(widget.pills[index].qrCode),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {},
                    ),
                  ),
                );
              },
              itemCount: widget.pills.length,
            ),
    );
  }
}
