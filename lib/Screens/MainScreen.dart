import 'package:apps/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Homepage.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> imageList = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f3751),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70,),
            Center(
              child: Row(
                children: [
                  SizedBox(height: 150,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 0, 20, 0),
                    child: Image.asset('assets/calendar-date.png',height: 101,width: 101,),
                  ),
                  Text("DAYS",style: GoogleFonts.lemon(fontSize: 50,color: Colors.white),)
                ],
              ),
            ),
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 318,
                  enlargeCenterPage: true,
                  aspectRatio: 16/9,
                  autoPlayCurve: Curves.bounceInOut,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 100),
                  viewportFraction: 0.8,
                ),
                items: imageList.map((String imagePath){
                  return Builder(builder: (BuildContext context){
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        )
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
            SizedBox(height: 40,),
            Text('Hey! Welcome',style: GoogleFonts.merriweather(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Text('Build and track habits',style: GoogleFonts.merriweather(fontSize: 15,color: Colors.white),),
            Text('with 21 days challenge app',style: GoogleFonts.merriweather(fontSize: 15,color: Colors.white),),
            SizedBox(height: 20,),
            Container(
              width: 200,
              child: ElevatedButton(onPressed: (){
                checkUser();
              },
              child: Text('Continue',style: GoogleFonts.merriweather(fontSize: 16,color: Colors.white),),
              style: ElevatedButton.styleFrom(
                primary: Color(0xffee2562),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
              ),
              )
            )
          ],
        ),
      ),
    );

  }
  checkUser() {
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    else{
      return Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));;
    }
  }

  
}

