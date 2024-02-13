import 'package:scratcher/scratcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Sleep extends StatefulWidget {
  const Sleep({super.key});

  @override
  State<Sleep> createState() => _SleepState();
}

class _SleepState extends State<Sleep> {
  List<bool> isDayCompleted = List.generate(21, (index) => false);
  late ConfettiController _confettiController;
  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 2));
    _loadCompletedDays();
  }
  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
  void _handleDayColorChange(int dayIndex) {
    setState(() {
      isDayCompleted[dayIndex] = !isDayCompleted[dayIndex];
    });
    _saveCompletedDays();
  }
  Future<void> _loadCompletedDays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < isDayCompleted.length; i++) {
        isDayCompleted[i] = prefs.getBool('Sleep day_$i') ?? false;
      }
    });
  }
  Future<void> _saveCompletedDays() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < isDayCompleted.length; i++) {
      prefs.setBool('Sleep day_$i', isDayCompleted[i]);
    }
  }
  void _showScratchCardDialoug( int dayIndex) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Scratcher(
          brushSize: 50,
          color: Color(0xff1f3751),
          child: Container(
            width: 200,
            height: 200,
            child: Center(
              child: Text(
                'Challenge : ${_getChallengeText(dayIndex)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),
              ),

            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(onPressed: (){
              _handleDayColorChange(dayIndex);
              _handleDayCompletion(dayIndex);

            }, child: Text('Challenge Completed',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),)),
          )
        ],
      );
    });
  }
  void _handleDayCompletion(int dayIndex){
    return setState((){
      isDayCompleted[dayIndex] = true;
      if(isAllDaysCompleted()){
        _showConfetti();
      }
    });
  }
  bool isAllDaysCompleted() {
    return isDayCompleted.every((completed) => completed);
  }
  String _getChallengeText(int dayIndex){
    List <String> ChallengeSentences = [
      'Put your phone away so in the next morning you have to get out of bed to turn the alarm off',
      'Put right lighting in your room',
      'Practise Relaxation, Breathe in Breathe out',
      'Avoid sleeping in the day',
      'Avoid Alcohol or Smoking at night',
      'Avoid Caffeine intake at night, Try Green Tea instead.',
      'Stay hydrated',
      'Set a consistent Bedtime',
      'Read a book',
      'Listen to calming music',
      'Bath/Shower before bed',
      'Eat Healthy',
      'Expose yourself to bright light in the morning',
      'Avoid heavy meals and sugary snacks before bed',
      'Track your progress',
      'Exercise Regularly',
      'Start Journaling before bed',
      'Avoid toxic people both online and offline',
      'Avoid going to bed hungry or stuffed, and drink lukewarm water after waking up',
      'Doing crosswords or Sudoku',
      'Remove TVs from the bedroom',
    ];
    return ChallengeSentences[dayIndex % ChallengeSentences.length];
  }

  void _showConfetti() {
    _confettiController.play();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Column(
          children: [
            Text('Congratulations! Challenge Completed!',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 25,fontWeight: FontWeight.bold),),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -1.0, // straight up
              emissionFrequency: 0.05,
              numberOfParticles: 20,
            ),
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f3751),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Text('Fix Your Sleep Schedule     ',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),)
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
          
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset('assets/day.png'),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Are you looking for ways to Improve your sleep quality? You'd like to wake up and go to bed early? Here we suggest you 21 strategies for that",style: GoogleFonts.merriweather(color: Colors.white,fontSize: 16),softWrap: true,textAlign: TextAlign.center,),
              ),
              SizedBox(height: 30,),
              SingleChildScrollView(
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                ),
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () {
                      _showScratchCardDialoug(index);
                    },
                    child: Card(
                      color: isDayCompleted[index]? Color(0xffee2562):Colors.transparent,
                      child: Center(
                        child: Text(
                            (index + 1).toString(),
                          style: GoogleFonts.merriweather(fontSize: 15,color: Colors.white),
                        ),
                      ),
                    ),
                  );
          
                },
                itemCount: 21,),
              ),
          
            ],
          ),
        ),
    );


  }
}
