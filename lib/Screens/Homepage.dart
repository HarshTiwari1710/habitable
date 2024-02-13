import 'package:apps/Screens/Anxiety.dart';
import 'package:apps/Screens/Declutter.dart';
import 'package:apps/Screens/Fitness.dart';
import 'package:apps/Screens/Health.dart';
import 'package:apps/Screens/Journal.dart';
import 'package:apps/Screens/Reading.dart';
import 'package:apps/Screens/Sleep.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Detox.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f3751),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('HABITABLE',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 18),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Center(child: Text('CHOOSE A HABIT',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
            SizedBox(height: 30,),
            Container(
              width: 320,
              height: 611,
              // color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 0,left: 0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30,top: 30),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffee2562),
                              radius: 42.5,
                              child: ClipOval(
                                child: Image.asset('assets/day.png',
                                width:55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),

                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Sleep()));
                            },
                          ),
                          SizedBox(width: 100,),
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffee2562),
                              radius: 42.5,
                              child: ClipOval(
                                child: Image.asset('assets/dumbbell.png',
                                  width:55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),

                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Fitness()));

                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Row(
                          children: [
                            Text('Sleep \n Schedule',style: GoogleFonts.merriweather(color: Color(0xff1f3751),fontSize: 15),softWrap: true,textAlign: TextAlign.center,),
                            SizedBox(width: 120,),
                            Text('Physical \n Fitness',style: GoogleFonts.merriweather(color: Color(0xff1f3751),fontSize: 15),softWrap: true,textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    SizedBox(height: 0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,top: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffee2562),
                              radius: 42.5,
                              child: ClipOval(
                                child: Image.asset('assets/book.png',
                                  width:55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Reading()));
                            },
                          ),
                          SizedBox(width: 100,),
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffee2562),
                              radius: 42.5,
                              child: ClipOval(
                                child: Image.asset('assets/detox.png',
                                  width:55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),

                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Detox()));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          Text('Reading',style: GoogleFonts.merriweather(color: Color(0xff1f3751),fontSize: 15),softWrap: true,textAlign: TextAlign.center,),
                          SizedBox(width: 125,),
                          Text('Digital \n Detox',style: GoogleFonts.merriweather(color: Color(0xff1f3751),fontSize: 15),softWrap: true,textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                    SizedBox(height: 0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,top: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffee2562),
                              radius: 42.5,
                              child: ClipOval(
                                child: Image.asset('assets/journal.png',
                                  width:55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Journal()));
                            },
                          ),
                          SizedBox(width: 100,),
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffee2562),
                              radius: 42.5,
                              child: ClipOval(
                                child: Image.asset('assets/folder.png',
                                  width:55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),

                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Declutter()));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          Text('Journal',style: GoogleFonts.merriweather(color: Color(0xff1f3751),fontSize: 15),softWrap: true,textAlign: TextAlign.center,),
                          SizedBox(width: 125,),
                          Text('Declutter',style: GoogleFonts.merriweather(color: Color(0xff1f3751),fontSize: 15),softWrap: true,textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,top: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffee2562),
                              radius: 42.5,
                              child: ClipOval(
                                child: Image.asset('assets/mental-health.png',
                                  width:55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Health()));
                            },
                          ),
                          SizedBox(width: 100,),
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffee2562),
                              radius: 42.5,
                              child: ClipOval(
                                child: Image.asset('assets/paranoia.png',
                                  width:55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),

                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Anxiety()));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          Text('Mental \n Health',style: GoogleFonts.merriweather(color: Color(0xff1f3751),fontSize: 15),softWrap: true,textAlign: TextAlign.center,),
                          SizedBox(width: 125,),
                          Text('Social \n Anxiety',style: GoogleFonts.merriweather(color: Color(0xff1f3751),fontSize: 15),softWrap: true,textAlign: TextAlign.center,)
                        ],
                      ),
                    ),


                  ],
                ),
              ),
              
            ),
            SizedBox(height: 5,),
            TextButton(onPressed: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                  content: Text('If you have a problem or have any feedback or suggestions. Please feel free to write us on "Habitable.help@gmail.com"',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 16),softWrap: true,textAlign: TextAlign.center,),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text('OK',style: GoogleFonts.merriweather(color: Color(0xff1f3751),fontSize: 16),)),
                  ],
                ));
            },style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.transparent

            ), child: Text('Have a Problem? Write to us.',style: GoogleFonts.merriweather(fontSize: 15),)),
          ],
        ),
      ),
    );
  }
}
