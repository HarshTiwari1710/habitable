import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:scratcher/scratcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Anxiety extends StatefulWidget {
  const Anxiety({super.key});

  @override
  State<Anxiety> createState() => _AnxietyState();
}

class _AnxietyState extends State<Anxiety> {
  List<bool> isDayCompletedAnxiety = List.generate(21, (index) => false);
  late ConfettiController confettiControllerAnxiety;
  @override
  void initState() {
    super.initState();
    confettiControllerAnxiety = ConfettiController(duration: Duration(seconds: 2));
    _loadCompletedDaysAnxiety();
  }
  @override
  void dispose() {
    confettiControllerAnxiety.dispose();
    super.dispose();
  }
  void _handleDayColorChangeAnxiety(int dayIndexAnxiety){
    setState(() {
      isDayCompletedAnxiety[dayIndexAnxiety] = !isDayCompletedAnxiety[dayIndexAnxiety];
    });
    _saveCompletedDaysAnxiety();
  }
  Future<void> _loadCompletedDaysAnxiety() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for(int i =0; i<isDayCompletedAnxiety.length;i++){
        isDayCompletedAnxiety[i] = prefs.getBool('Anxiety day_$i')?? false;
      }
    });
  }
  Future<void> _saveCompletedDaysAnxiety() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int i = 0; i<isDayCompletedAnxiety.length;i++){
      prefs.setBool('Anxiety day_$i', isDayCompletedAnxiety[i]);
    }
  }
  void _showScratchCardDialog(int dayIndexAnxiety) {
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
                'Challenge: ${_getChallengeTextAnxiety(dayIndexAnxiety)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),
              ),
            ),
          ),
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 20),
            child: TextButton(onPressed: (){
              _handleDayColorChangeAnxiety(dayIndexAnxiety);
              _handleDayCompletionAnxiety(dayIndexAnxiety);
            },
              child: Text('Challenge Completed',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),),

            ),
          )
        ],
      );
    });
  }
  void _handleDayCompletionAnxiety(int dayIndexAnxiety){
    return setState(() {
      isDayCompletedAnxiety[dayIndexAnxiety] = true;
      if(isAllDaysCompletedAnxiety()){
        _showConfetti();
      }
    });
  }
  bool isAllDaysCompletedAnxiety(){
    return isDayCompletedAnxiety.every((completed) => completed);
  }
  String _getChallengeTextAnxiety(int dayIndexAnxiety) {
    List <String> ChallengeSentencesAnxiety = [
      'Reconnect with an Old Friend',
      'Compliment Someone',
      'Maintain Eye Contact during a conversation',
      'Unfollow people on social Media that do not make you feel good ',
      'Go for a walk alone',
      'Invite someone out for a lunch or dinner',
      'Eat Something',
      'Pay attention to your surroundings',
      'Using mindfulness',
      'Take your time it is not one night story',
      'Start Taking baby steps be comfortable around one or two surroundings',
      'Practise when you can',
      'Authenticity counts',
      'Avoid overthinking',
      'An activity can help',
      'Acting confident',
      'Sleep hygiene',
      'Counteracting negative thoughts',
      'Be curious',
      'Giving yourself credit',
      'It’s OK to say no',
    ];
    return ChallengeSentencesAnxiety[dayIndexAnxiety&ChallengeSentencesAnxiety.length];
  }
  void _showConfetti(){
    confettiControllerAnxiety.play();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          width: 200,
          height: 200,
          child: Column(
            children: [
              Text('Congratulations! Challenge Completed!',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ConfettiWidget(
                confettiController: confettiControllerAnxiety,
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
          Text('Recover from Social Anxiety    ',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),
            child: Center(child: Image.asset('assets/paranoia.png',),),
            ),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
            Text("You'll start overcoming social anxiety if you gradually expose yourself to social situations. Here are 21 daily social anxiety challenges. With practice, it will get better and you'l start feeling more confident.",style: GoogleFonts.merriweather(color: Colors.white,fontSize: 16),softWrap: true,textAlign: TextAlign.center,),
SizedBox(height: 30,),
            SingleChildScrollView(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0
              ),
                  shrinkWrap: true,
                  itemBuilder: (context,index) {
                return GestureDetector(
                  onTap: (){
                    _showScratchCardDialog(index);
                  },
                  child: Card(
                    color: isDayCompletedAnxiety[index]? Color(0xffee2562):Colors.transparent,
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
