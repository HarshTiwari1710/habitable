import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  forgotpassword(String email)async{
    if(email == null){
      return showDialog(context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: Text('Forgot',style: GoogleFonts.merriweather(color: Colors.white),),
                backgroundColor: Color(0xff1f3751),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text('Please Enter the required Details',style: GoogleFonts.merriweather(color: Colors.white),),
                    ],
                  ),
                ),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text('OK',style: GoogleFonts.merriweather(color: Colors.white),))
                ],
              )

      );
    }
    else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f3751),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Text('Forgot Password',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 18),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: TextFormField(
                controller: emailController,
                style: GoogleFonts.merriweather(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.white
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Email',
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              forgotpassword(emailController.text.toString());
            },style: ElevatedButton.styleFrom(
             primary: Color(0xffee2562),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10.0)
             )
            ), child: Text('Reset Password',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),)),
          ],
        ),
      ),
    );
  }
}
