import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scratcher/scratcher.dart';
class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {
  List<bool> isDayCompletedHealth = List.generate(21, (index) => false);
  late ConfettiController confettiControllerHealth;
  @override
  void initState() {
    super.initState();
    confettiControllerHealth = ConfettiController(duration: Duration(seconds: 2));
    _loadCompletedDaysHealth();
  }
  @override
  void dispose() {
    confettiControllerHealth.dispose();
    super.dispose();
  }
  void _handleDayColorChangeHealth(int dayIndexHealth){
    setState(() {
      isDayCompletedHealth[dayIndexHealth] = !isDayCompletedHealth[dayIndexHealth];
    });
    _saveCompletedDaysHealth();
  }
  Future<void> _loadCompletedDaysHealth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for(int i =0; i<isDayCompletedHealth.length;i++){
        isDayCompletedHealth[i] = prefs.getBool('Health day_$i')?? false;
      }
    });
  }
  Future<void> _saveCompletedDaysHealth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int i = 0; i<isDayCompletedHealth.length;i++){
      prefs.setBool('Health day_$i', isDayCompletedHealth[i]);
    }
  }
  void _showScratchCardDialog(int dayIndexHealth) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Scratcher(
          brushSize: 50,
          color: Color(0xff1f3751),
          child: Container(
            width: 200,
            height: 200,
            child: Center(
              child: Text(
                'Challenge: ${_getChallengeTextHealth(dayIndexHealth)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),
              ),
            ),
          ),
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 20),
            child: TextButton(onPressed: (){
              _handleDayColorChangeHealth(dayIndexHealth);
              _handleDayCompletionHealth(dayIndexHealth);
            },
              child: Text('Challenge Completed',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),),

            ),
          )
        ],
      );
    });
  }
  void _handleDayCompletionHealth(int dayIndexHealth){
    return setState(() {
      isDayCompletedHealth[dayIndexHealth] = true;
      if(isAllDaysCompletedHealth()){
        _showConfetti();
      }
    });
  }
  bool isAllDaysCompletedHealth(){
    return isDayCompletedHealth.every((completed) => completed);
  }
  String _getChallengeTextHealth(int dayIndexHealth) {
    List <String> ChallengeSentencesHealth = [
      'Establish a routine',
      'Control how much news you consume',
      'Set boundaries with work',
      'Be open about how you feel',
      'Stay hydrated',
      'Use food to boost your mood',
      'Deepen your relationships',
      'Exercise regularly',
      'Rest up',
      'Find perspective',
      'Get creative',
      'Keep learning',
      'Practice gratitude',
      'Give to others in need',
      'Cook more',
      'Listen to music',
      'Get some fresh air',
      'Call an Old Friend',
      'Prioritize self-care',
      'Be still',
      'Reduce Alcohol Intake',
    ];
    return ChallengeSentencesHealth[dayIndexHealth&ChallengeSentencesHealth.length];
  }
  void _showConfetti(){
    confettiControllerHealth.play();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          width: 200,
          height: 200,
          child: Column(
            children: [
              Text('Congratulations! Challenge Completed!',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ConfettiWidget(
                confettiController: confettiControllerHealth,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f3751),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Text('Improve your Mental Health      ',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),
            child: Center(child: Image.asset('assets/mental-health.png'),),
            ),
            SizedBox(height: 50,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Improve your mental health with these 21 tips and push you limits forward',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 16),softWrap: true,textAlign: TextAlign.center,),
            ),
            SizedBox(height: 30,),
            SingleChildScrollView(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
              ),
                  shrinkWrap: true
                  , itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    _showScratchCardDialog(index);
                  },
                  child: Card(
                    color: isDayCompletedHealth[index]?Color(0xffee2562):Colors.transparent,
                    child: Center(
                      child: Text(
                          (index + 1).toString(),
                        style: GoogleFonts.merriweather(fontSize: 15,color: Colors.white),
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
