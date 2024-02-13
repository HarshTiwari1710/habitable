import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:scratcher/scratcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  List<bool> isDayCompletedJournal = List.generate(21, (index) => false);
  late ConfettiController confetticontrollerJournal;
  @override
  void initState() {
    super.initState();
    confetticontrollerJournal = ConfettiController(duration: Duration(seconds: 2));
    _loadCompleteDaysJournal();
  }
  @override
  void dispose() {
    confetticontrollerJournal.dispose();
    super.dispose();
  }
  void _handleDayColorChangeJournal(int dayIndexJournal){
    setState(() {
      isDayCompletedJournal[dayIndexJournal] = !isDayCompletedJournal[dayIndexJournal];
    });
    _saveCompletedDaysJournal();
  }
  Future<void> _loadCompleteDaysJournal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for( int i = 0; i<isDayCompletedJournal.length;i++) {
        isDayCompletedJournal[i] = prefs.getBool('Journal day_$i')?? false;
      }
    });
  }
  Future<void> _saveCompletedDaysJournal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int i =0; i<isDayCompletedJournal.length;i++){
      prefs.setBool('Journal day_$i', isDayCompletedJournal[i]);
    }
  }
  void _showScratchCardDialog(int dayIndexJournal){
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
                'Challenge: ${_getChallengeTextJournal(dayIndexJournal)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),
              ),
            ),
          ),
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 20),
            child: TextButton(onPressed: (){
              _handleDayColorChangeJournal(dayIndexJournal);
              _handleDayCompletionJournal(dayIndexJournal);
            },
              child: Text('Challenge Completed',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),),

            ),
          )
        ],
      );
    });
  }
  void _handleDayCompletionJournal(int dayIndexJournal){
    return setState(() {
      isDayCompletedJournal[dayIndexJournal] = true;
      if(isAllDaysCompletedJournal()){
        _showConfetti();
      }
    });
  }
  bool isAllDaysCompletedJournal(){
    return isDayCompletedJournal.every((completed) => completed);
  }
  String _getChallengeTextJournal(int dayIndexJournal) {
    List <String> ChallengeSentencesJournal = [
      'Write About What you are feeling today',
      'Write about what are your top priorities for the day',
      'What did you learn today? How can you apply this knowledge in the future',
      'What was a moment of joy, delight, or contentment today?',
      'What was a small detail you noticed today?',
      'What was the best thing that happened to you today?',
      'What is something that made you laugh today?',
      'What steps did you take today toward a goal you’re working on?',
      'Who made your day better today? How can you pay that feeling forward?',
      'What made today unique?',
      'What is one thing you want to remember from today?',
      'When did you feel most authentically yourself today?',
      'How can you make tomorrow (even) better than today?',
      'What’s something that’s working well in your life right now?',
      'What’s a simple pleasure in your life that you are thankful for?',
      'What does love mean to you?',
      'When was the first time that you fell in love with somebody else?'
      'What do you love about your partner? If you don’t have one, name three qualities that you’d love to find in a future partner.',
      'If you were given 10,000 dollars and only an hour to spend it, how would you do it?',
      'How would you describe your spirituality?'
      'If you could, would you go back 10 years in your life? Why or why not?'
    ];
    return ChallengeSentencesJournal[dayIndexJournal%ChallengeSentencesJournal.length];
  }
  void _showConfetti(){
    confetticontrollerJournal.play();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          width: 200,
          height: 200,
          child: Column(
            children: [
              Text('Congratulations! Challenge Completed!',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ConfettiWidget(
                confettiController: confetticontrollerJournal,
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
          Text('Improve Your Reading Habit   ',style: GoogleFonts.merriweather(color: Colors.white),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),
            child: Center(child: Image.asset('assets/journal.png'),),
            ),
            SizedBox(height: 50,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('21 days of journal prompts to help you start building your journaling habit.',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 16),softWrap: true,textAlign: TextAlign.center,),
            ),
            SizedBox(height: 30,),
            SingleChildScrollView(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
              ),
                  shrinkWrap: true,
                  itemBuilder: (context,index) {
                return GestureDetector(
                  onTap: (){
                    _showScratchCardDialog(index);
                  },
                  child: Card(
                    color: isDayCompletedJournal[index]?Color(0xffee2562):Colors.transparent,
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
            )
          ],
        ),
      ),
    );
  }
}
