import 'package:scratcher/scratcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Fitness extends StatefulWidget {
  const Fitness({super.key});

  @override
  State<Fitness> createState() => _FitnessState();
}

class _FitnessState extends State<Fitness> {
  List<bool> isDayCompletedFitness = List.generate(21, (index) => false);
  late ConfettiController confettiController;
  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(duration: Duration(seconds: 2));
    _loadCompletedDaysFitness();

  }
  @override
  void dispose() {
    confettiController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void _handleDayColorChangeFitness(int dayIndexFitness){
    setState(() {
      isDayCompletedFitness[dayIndexFitness] = !isDayCompletedFitness[dayIndexFitness];
    });
    _saveCompletedDaysFitness();
  }
  Future<void> _loadCompletedDaysFitness() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for(int i = 0; i<isDayCompletedFitness.length;i++){
        isDayCompletedFitness[i] = prefs.getBool('exercise day_$i')?? false;
      }
    });
  }
  Future<void> _saveCompletedDaysFitness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for(int i = 0; i<isDayCompletedFitness.length;i++){
      prefs.setBool('exercise day_$i', isDayCompletedFitness[i]);
    }
  }
  void _showScratchCardDialog(int dayIndexFitness){
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
                'Challenge: ${_getChallengeTextFitness(dayIndexFitness)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),
              ),
            ),
          ),
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 20),
          child: TextButton(onPressed: (){
            _handleDayColorChangeFitness(dayIndexFitness);
            _handleDayCompletionFitness(dayIndexFitness);
          },
          child: Text('Challenge Completed',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 15),),

          ),
          )
        ],
      );
    });
  }
  void _handleDayCompletionFitness(int dayIndexFitness){
    return setState(() {
      isDayCompletedFitness[dayIndexFitness] = true;
      if(isAllDaysCompletedFitness()){
        _showConfetti();
      }
    });
  }
  bool isAllDaysCompletedFitness(){
    return isDayCompletedFitness.every((completed) => completed);
  }
  String _getChallengeTextFitness(int dayIndexFitness){
    List <String> ChallengeSententencesFitness = [
      '20 sitUps, 20 Squats, 10 pushups, 30 sec plank',
      '15 burpees, 15 leg raises, 20 jumping jacks, 20 sec wall sit',
      'Chest Fly 10 reps',
      'Push up/Plank Combo 10 reps switch side repeat',
      'Reverse Lunges 15 reps switch side repeat',
      'Squat Chair Pose 10 reps increase the weight repeat',
      'Plie Squats 15 reps increase the weight repeat',
      'Biceps curl 15 reps switch weight repeat',
      'Inner/Outer Leg Fit 15 reps switch sides Repeat',
      'Back Fly 15 reps scale weights repeat',
      'Roll Up 8 reps',
      'Side Reach 10 reps',
      'Boat Pose hold 2 minutes 3 reps',
      'Cardio - Walking Jogging, Cycling 45 minutes',
      'Track your progress',
      '30 jumping jacks, 15 step-ups, 10 sit-ups, 20 ab bikes, 20 alternating lunges',
      '30 mountain climbers, 20 squats, 8 push-ups, 20 butt kicks, 25 toe touch crunches',
      '40 jumping jacks, 30 alternative lunges, 30 crunches, 8 push-ups, 25-second plank',
      '30 mountain climbers, 8 push-ups, 30 crunches, 20 walking lunges, 30-second wall sit',
      '25 butt kicks, 15 triceps dips, 12 burpees, 20 squats, 30 toe touch crunches',
      '30 mountain climbers, 8 push-ups, 30 crunches, 20 walking lunges, 30-second wall sit',
    ];
    return ChallengeSententencesFitness[dayIndexFitness%ChallengeSententencesFitness.length];
  }
  void _showConfetti(){
    confettiController.play();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Container(
          width: 200,
          height: 200,
          child: Column(
            children: [
              Text('Congratulations! Challenge Completed!',style: GoogleFonts.merriweather(color: Color(0xffee2562),fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ConfettiWidget(
                confettiController: confettiController,
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
          Text('Improve your physical Fitness     ',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),)
        ],
      ),
      body:SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 30),
                child: Center(child: Image.asset('assets/dumbbell.png')),
              ),
              SizedBox(height: 50,),
              Text("Stay physically active with this home workout. Take your time, every move counts",style: GoogleFonts.merriweather(color: Colors.white,fontSize: 16),softWrap: true,textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              SingleChildScrollView(
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:5,
                  childAspectRatio:1.0,
                ),
                    shrinkWrap: true,
                    itemBuilder: (context,indexFitness){
                  return GestureDetector(
                    onTap: (){
                      _showScratchCardDialog(indexFitness);
                    },
                    child: Card(
                      color: isDayCompletedFitness[indexFitness]? Color(0xffee2562):Colors.transparent,
                      child: Center(
                        child: Text(
                            (indexFitness + 1).toString(),
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

