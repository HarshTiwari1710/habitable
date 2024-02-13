import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:scratcher/scratcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Reading extends StatefulWidget {
  const Reading({super.key});

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  List<bool> ReadingComplete = List.generate(21, (index) => false);
  late ConfettiController confettiControllerReading;
  @override
  void initState() {
    super.initState();
    confettiControllerReading = ConfettiController(duration: Duration(seconds: 2));
    _loadCompletedDaysReading();
  }
  @override
  void dispose() {
    confettiControllerReading.dispose();
    super.dispose();
  }
  void _handleDayColorChangeReading(int dayIndexReading){
    setState(() {
      ReadingComplete[dayIndexReading] = !ReadingComplete[dayIndexReading];
    });
    _saveCompletedDaysReading();
  }
  Future<void> _loadCompletedDaysReading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for(int i =0; i<ReadingComplete.length;i++){
        ReadingComplete[i] = prefs.getBool('Reading day_$i')?? false;
      }
    });
  }
  Future<void> _saveCompletedDaysReading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int i = 0; i<ReadingComplete.length;i++){
      prefs.setBool('Reading day_$i', ReadingComplete[i]);
    }
  }
  void _showScratchCardDialog(int dayIndexReading) {
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
                'Challenge: ${_getChallengeTextReading(dayIndexReading)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),
              ),
            ),
          ),
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 20),
            child: TextButton(onPressed: (){
              _handleDayColorChangeReading(dayIndexReading);
              _handleDayCompletionReading(dayIndexReading);
            },
              child: Text('Challenge Completed',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),),

            ),
          )
        ],
      );
    });
  }
  void _handleDayCompletionReading(int dayIndexReading){
    return setState(() {
      ReadingComplete[dayIndexReading] = true;
      if(isAllDaysCompletedReading()){
        _showConfetti();
      }
    });
  }
  bool isAllDaysCompletedReading(){
    return ReadingComplete.every((completed) => completed);
  }
  String _getChallengeTextReading(int dayIndexReading) {
    List <String> ChallengeSentencesReading = [
      'The morning miracle by Hal Elrod',
      'The Power of Habit by Charles Duhigg',
      'Sleep Smarter by Shawn Stevenson',
      'Johnathan Livingston Seagull by Richard Bach',
      'One Up On Wall Street by Peter Lynch',
      'Moonwalking with Einstein by Joshua Foer',
      'Quite the power of introvert by Susan Cain',
      'Measure What Matters by John Doerr',
      'Frekonomics by Lavitt and Dubner',
      'Fast food Genocide By Joel Fuhrman',
      'Influence the phycology of persuasion by Robert D. Cialdini',
      'The God Delusion by Richard Dawkins',
      'Midnight in Chernobyl by Adam',
      'Eating Animals by Jonathan Safean Foer',
      'The brief history of Time by Stephen Hawking',
      'Attitude is everything by Jeff Keller',
      'Harry Potter and the prisoner of azkaban by J.K Rowling',
      'The Alchemist by Paulo Coelho',
      'Malgudi Days by RK Narayan',
      'A Thousand Splendid Suns by Khaled Hosseini',
      'The Art of Racing in the Rain by Garth Stein',
    ];
    return ChallengeSentencesReading[dayIndexReading&ChallengeSentencesReading.length];
  }
  void _showConfetti(){
    confettiControllerReading.play();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          width: 200,
          height: 200,
          child: Column(
            children: [
              Text('Congratulations! Challenge Completed!',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ConfettiWidget(
                confettiController: confettiControllerReading,
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
          Text('Improve your Reading Habit    ',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),
            child: Center(child: Image.asset('assets/book.png',height: 100,width: 100,),),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Improve your Reading Skills. Start with these 21 awesome books to improve your reading skills",style: GoogleFonts.merriweather(color: Colors.white,fontSize: 16),softWrap: true,textAlign: TextAlign.center,),
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
                    color: ReadingComplete[index]? Color(0xffee2562):Colors.transparent,
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
