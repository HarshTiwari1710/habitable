import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scratcher/scratcher.dart';
class Detox extends StatefulWidget {
  const Detox({super.key});

  @override
  State<Detox> createState() => _DetoxState();
}

class _DetoxState extends State<Detox> {
  List<bool> isDayCompletedDetox = List.generate(21, (index) => false);
  late ConfettiController confetticontrollerDetox;
  @override
  void initState() {
    super.initState();
    confetticontrollerDetox = ConfettiController(duration: Duration(seconds: 2));
    _loadCompletedDaysDetox();
  }
  @override
  void dispose() {
    confetticontrollerDetox.dispose();
    super.dispose();
  }
  void _handleDayColorChangeDetox(int dayIndexDetox){
    setState(() {
      isDayCompletedDetox[dayIndexDetox] = !isDayCompletedDetox[dayIndexDetox];
    });
    _saveCompletedDaysDetox();
  }
  Future<void> _loadCompletedDaysDetox() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i<isDayCompletedDetox.length;i++){
        isDayCompletedDetox[i] = prefs.getBool('Detox day_$i')?? false;
      }
    });
  }
  Future<void> _saveCompletedDaysDetox() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int i = 0; i<isDayCompletedDetox.length;i++){
      prefs.setBool('Detox day_$i', isDayCompletedDetox[i]);
    }
  }
  void _showScratchCardDialog(int dayIndexDetox){
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
                'Challenge: ${_getChallengeTextDetox(dayIndexDetox)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),
              ),
            ),
          ),
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 20),
            child: TextButton(onPressed: (){
              _handleDayColorChangeDetox(dayIndexDetox);
              _handleDayCompletionDetox(dayIndexDetox);
            },
              child: Text('Challenge Completed',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),),

            ),
          )
        ],
      );
    });
  }
  void _handleDayCompletionDetox(int dayIndexDetox) {
    return setState(() {
      isDayCompletedDetox[dayIndexDetox] =true;
      if(isAllDaysCompletedDetox()){
      _showConfetti();
      }
    });
  }
  bool isAllDaysCompletedDetox(){
    return isDayCompletedDetox.every((completed) => completed);
  }
  String _getChallengeTextDetox(int dayIndexDetox) {
    List <String> ChallengeSentencesDetox = [
      'Pay attention to and internally note every time you feel the impulse or hear the thought to check one of your devices or computer',
      'Refrain from any tech use when socializing or otherwise interacting with people.',
      'Refrain from holding your device in your hand or keeping it in your pocket when it’s not in use',
      'Refrain from using any of your devices during the first hour after you wake up in the morning',
      'Refrain from using tech devices during the last hour before you go to bed.',
      'Turn off all alerts and notifications on your device. If your cell phone is your alarm clock, leave only the alarm notification intact.',
      'Refrain from using your devices on public transportation or in taxis.',
      'Write down four activities or experiences that nourish your spirit.',
      'Refrain from using your devices while waiting in line — any kind of line.',
      'Refrain from using technology in the car, except when you need GPS assistance.',
      'Refrain from using while waiting for something to begin, such as a movie, a play, a concert or a social interaction.',
      'Refrain from using during events — for example, at concerts, the theater or children’s recitals.',
      'Make your bathroom a tech-free zone.',
      'Refrain from using technology while walking on the street.',
      'Make your bedroom a tech-free zone. Remove all devices and computers and refrain from using in the room or area where you sleep.',
      'Set aside two continuous three-hour blocks of time in the day when you will be tech-free',
      'Refrain from using while exercising, unless you are providing yourself with music.',
      'Refrain from immediately using the internet to research non-work-related information that you have forgotten or want to know',
      'If there is a website that is particularly addictive for you, sign up for Net Nanny or another service that prevents you from accessing it.',
      'Refrain from tech use while cooking and eating.',
      'Refrain from using when walking or being in nature.',
    ];
    return ChallengeSentencesDetox[dayIndexDetox%ChallengeSentencesDetox.length];
  }
  void _showConfetti(){
    confetticontrollerDetox.play();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          width: 200,
          height: 200,
          child: Column(
            children: [
            Text('Congratulations! Challenge Completed!',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          ConfettiWidget(
            confettiController:  confetticontrollerDetox,
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
          Text('Digitally Detox yourself      ',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30),
              child: Center(child: Image.asset('assets/detox.png')),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('If you go through this 21 days digital decluttering challenge, you will feel lighter, more productive, and more in control of your digital life',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 16),softWrap: true,textAlign: TextAlign.center,),
            ),
            SizedBox(height: 30,),
            SingleChildScrollView(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0
              ),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    _showScratchCardDialog(index);
                  },
                  child: Card(
                    color: isDayCompletedDetox[index]? Color(0xffee2562):Colors.transparent,
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
