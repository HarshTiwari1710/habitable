import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scratcher/scratcher.dart';
class Declutter extends StatefulWidget {
  const Declutter({super.key});

  @override
  State<Declutter> createState() => _DeclutterState();
}

class _DeclutterState extends State<Declutter> {
  List<bool> isDayCompletedDeclutter = List.generate(21, (index) => false);
  late ConfettiController confettiControllerDeclutter;
  @override
  void initState() {
    super.initState();
    confettiControllerDeclutter = ConfettiController(duration: Duration(seconds: 2));
    _loadCompletedDaysDeclutter();
  }
  @override
  void dispose() {
    confettiControllerDeclutter.dispose();
    super.dispose();
  }
  void _handleDayColorChangeDeclutter(int dayIndexDeclutter){
    setState(() {
      isDayCompletedDeclutter[dayIndexDeclutter] = !isDayCompletedDeclutter[dayIndexDeclutter];
    });
    _saveCompletedDaysDeclutter();
  }
  Future<void> _loadCompletedDaysDeclutter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for(int i =0; i<isDayCompletedDeclutter.length;i++){
        isDayCompletedDeclutter[i] = prefs.getBool('Declutter day_$i')?? false;
      }
    });
  }
  Future<void> _saveCompletedDaysDeclutter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int i = 0; i<isDayCompletedDeclutter.length;i++){
      prefs.setBool('Declutter day_$i', isDayCompletedDeclutter[i]);
    }
  }
  void _handleDayCompletionDeclutter(int dayIndexDeclutter){
    return setState(() {
      isDayCompletedDeclutter[dayIndexDeclutter] = true;
      if(isAllDaysCompletedDeclutter()){
        _showConfetti();
      }
    });
  }
  bool isAllDaysCompletedDeclutter(){
    return isDayCompletedDeclutter.every((completed) => completed);
  }
  String _getChallengeTextDeclutter(int dayIndexDeclutter) {
    List <String> ChallengeSentencesDeclutter = [
      'Return Items To Their Original Spot',
      'Avoid Lids',
      'Use Drawer Organisers',
      'Work Clearing Surfaces Into Your Routine',
      'Use Clear Containers',
      'Arrange Things By How Often You Use Them',
      'Set Boundaries',
      'Try New Folding Techniques',
      'Color Code Your Files',
      'Hang Pots & Pans',
      'Use Magnetic Strips',
      'Contain Playtime With A Blanket',
      'Store Shoes Heel To Toe',
      'Reclaim Your Storage Space',
      'Embrace the “Drop Zone”',
      'Contain Plastic Bags',
      'Practice One In, One Out',
      'Identify What You Wear',
      'Take The 12-12-12 challenge ',
      'ORGANISE INTO CATEGORIES',
      'LABEL EVERYTHING',
    ];
    return ChallengeSentencesDeclutter[dayIndexDeclutter&ChallengeSentencesDeclutter.length];
  }
  void _showConfetti(){
    confettiControllerDeclutter.play();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          width: 200,
          height: 200,
          child: Column(
            children: [
              Text('Congratulations! Challenge Completed!',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ConfettiWidget(
                confettiController: confettiControllerDeclutter,
                blastDirection: -1.0, // straight up
                emissionFrequency: 0.05,
                numberOfParticles: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
  void _showScratchCardDialog(int dayIndexDeclutter) {
    bool isCardAlreadyScratched = false;
    bool isCardScratched = false;
    if (isCardAlreadyScratched == false) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Scratcher(
            onChange: (value) {
              if (value >= 1) {
                setState(() {
                  isCardScratched = true;
                });
              }
            },
            onScratchEnd: () {
              setState(() {
                isCardAlreadyScratched = true;
              });
            },
            brushSize: 50,
            color: Color(0xff1f3751),
            child: Container(
              width: 200,
              height: 200,
              child: Center(
                child: Text(
                  'Challenge : ${_getChallengeTextDeclutter(dayIndexDeclutter)}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                      color: Color(0xffee2562), fontSize: 15),
                ),

              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(onPressed: () {
                if (isCardScratched == true) {
                  _handleDayCompletionDeclutter(dayIndexDeclutter);
                  _handleDayColorChangeDeclutter(dayIndexDeclutter);
                } else {
                  null;
                }
              },
                  child: Text('Challenge Completed',
                    style: GoogleFonts.merriweather(
                        color: Color(0xffee2562), fontSize: 15),)),
            )
          ],
        );
      });
    } else if (isCardAlreadyScratched == true) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Container(
            width: 200,
            height: 200,
            child: Center(
              child: Text(
                'Challenge : ${_getChallengeTextDeclutter(dayIndexDeclutter)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(
                    color: Color(0xffee2562), fontSize: 15),
              ),

            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(onPressed: () {
                if (isCardScratched == true) {
                  _handleDayColorChangeDeclutter(dayIndexDeclutter);
                  _handleDayCompletionDeclutter(dayIndexDeclutter);
                } else {
                  null;
                }
              },
                  child: Text('Challenge Completed',
                    style: GoogleFonts.merriweather(
                        color: Color(0xffee2562), fontSize: 15),)),
            )
          ],
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f3751),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Text('Declutter your Desk And Room      ' ,style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),
            child: Center(child: Image.asset('assets/folder.png'),),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Declutter your Desk and Room with these 21 amazing ideas",style: GoogleFonts.merriweather(color: Colors.white,fontSize: 16),softWrap: true,textAlign: TextAlign.center,),
            ),
            SizedBox(height: 30,),
            SingleChildScrollView(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0
              ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    _showScratchCardDialog(index);
                  },
                  child: Card(
                    color: isDayCompletedDeclutter[index]? Color(0xffee2562): Colors.transparent,
                    child: Center(
                      child: Text(
                          (index + 1).toString(),
                        style: GoogleFonts.merriweather(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                );
                  },
              itemCount: 21,
              ),
            )
          ],
        ),
      ),
    );
  }
}
