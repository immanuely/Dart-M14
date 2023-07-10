import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Pertemuan14Screen extends StatefulWidget {
  const Pertemuan14Screen({super.key});

  @override
  State<Pertemuan14Screen> createState() => _Pertemuan14ScreenState();
}

class _Pertemuan14ScreenState extends State<Pertemuan14Screen> {
  DateTime _date = DateTime.now();
  DateTimeRange? _dateRange;
  TextEditingController? _time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pertemuan 14'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: [
            Row(
              children: [
                Text('Tanggal:'),
                SizedBox(width: 10),
                Expanded(
                    child: InputDatePickerFormField(
                  initialDate: _date,
                  firstDate: DateTime(1999),
                  lastDate: DateTime(2250),
                  onDateSubmitted: (date) {
                    _date = date;
                    print(_date);
                  },
                )),
                IconButton(
                    onPressed: () async {
                      var res = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2500));

                      if (res != null) {
                        setState(() {
                          _date = res;
                        });
                      }
                    },
                    icon: Icon(Icons.date_range))
              ],
            ),
            ListTile(
              title: Text('Tanggal terpilih'),
              subtitle: Text(_date.toString()),
            ),
            Divider(),
            Row(
              children: [
                Text('Jam: '),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  enabled: false,
                  controller: _time,
                  decoration: InputDecoration(labelText: 'Jam'),
                )),
                IconButton(
                    onPressed: () async {
                      var res = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (res != null) {
                        setState(() {
                          _time =
                              TextEditingController(text: res.format(context));
                        });
                      }
                    },
                    icon: Icon(Icons.timer))
              ],
            ),
            Row(
              children: [
                Text(' Range Tanggal:'),
                SizedBox(width: 10),
                Expanded(
                    child: TextField(
                  enabled: false,
                  controller: TextEditingController(
                    text: _dateRange != null
                        ? '${_dateRange!.start.toString().split(' ')[0]} - ${_dateRange!.end.toString().split(' ')[0]}'
                        : '',
                  ),
                )),
                IconButton(
                    onPressed: () async {
                      var res = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000, 01, 01),
                          lastDate: DateTime(2030, 12, 31),
                          currentDate: DateTime.now());

                      if (res != null) {
                        print(res.start.toString());
                        setState(() {
                          _dateRange = res;
                        });
                      }
                    },
                    icon: Icon(Icons.date_range)),
              ],
            ),
            if (_dateRange != null)
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rentang Tanggal Terpilih : '),
                    Column(
                      children: [
                        for (int i = 0;
                            i <=
                                _dateRange!.end
                                    .difference(_dateRange!.start)
                                    .inDays;
                            i++)
                          Text((_dateRange!.start.add(Duration(days: i)))
                              .toString()
                              .split(' ')[0]),
                      ],
                    ),
                  ],
                ),
              ),
          ]),
        ));
  }
}
