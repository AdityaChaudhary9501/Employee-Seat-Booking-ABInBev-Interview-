import 'package:ab_inbev/screens/seatbooking.dart';
import 'package:ab_inbev/screens/vaccinationscreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController controller=PageController();
  final int _currentIndex=0;


  onTap(index){
    setState(() {
      
      controller.animateToPage(index, duration: Duration(microseconds: 30), curve: Curves.bounceOut);
    });

  }

  @override
  void initState(){
    super.initState();
    controller=PageController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          vaccinationscreen(),
          seatbooking()

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            onTap(index );

          });

        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Vaccination Status'),
          BottomNavigationBarItem(icon: Icon(Icons.web_asset_off_rounded),label: 'Seat Booking')
        ],
      )
    );
  }
}
