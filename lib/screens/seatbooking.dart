import 'package:flutter/material.dart';

class seatbooking extends StatefulWidget {
  const seatbooking({Key? key}) : super(key: key);

  @override
  State<seatbooking> createState() => _seatbookingState();
}

class _seatbookingState extends State<seatbooking> {
  DateTime date=DateTime(2022,11,29);
  TimeOfDay time= TimeOfDay(hour: 09, minute: 00);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Seat Booking'),
      ),
      body:Center(
        child:Column(
          children:[
              Text('Seat Booking Screen'),

              const SizedBox(height:16),
              ElevatedButton(
                 child: Text('Select the date'),
                 onPressed: () async{
                   DateTime? newDate= await showDatePicker(context: context, initialDate: date, firstDate: DateTime(1900), lastDate: DateTime(2100),);
                 },
              ),

              const SizedBox(height: 16),
               ElevatedButton(
                    child: Text('Select your in time'),
                    onPressed: () async{
                       TimeOfDay? newTime= await showTimePicker(context: context, initialTime: time,);
                     },
               ),
              const SizedBox(height: 16),
              ElevatedButton(
                     child: Text('Select your out time'),
                     onPressed: () async{
                         TimeOfDay? newTime= await showTimePicker(context: context, initialTime: time,);
                     },
              )
          ]
        )
      ),
    );
  }
}
