import 'package:apps/Screens/Homepage.dart';
import 'package:apps/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isObsecure = false;
  void togglePassWordVisibility() {
    setState(() {
      _isObsecure = !_isObsecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseauth = FirebaseAuth.instance;
      final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
      TextEditingController _emailController = TextEditingController();
      TextEditingController _passwordController = TextEditingController();
      signup(String email, String password) async {
        if(email =="" && password==""){
          showDialog(context: context, builder: (BuildContext context) =>
          AlertDialog(
            title: Text('SignUp',style: GoogleFonts.merriweather(color: Colors.white),),
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
          ));

        } else {
          UserCredential? usercrential;
          try {
            usercrential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {

              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            });
          }
          on FirebaseAuthException catch(ex) {
            return showDialog(context: context, builder: (BuildContext context) =>
                AlertDialog(
                  title: Text('SignUp',style: GoogleFonts.merriweather(color: Colors.white),),
                  backgroundColor: Color(0xff1f3751),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Text(ex.code.toString(),style: GoogleFonts.merriweather(color: Colors.white),),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text('OK',style: GoogleFonts.merriweather(color: Colors.white),))
                  ],
                ));

          }
        }
      }
      return Scaffold(
        backgroundColor: Color(0xff1f3751),
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Padding(padding: EdgeInsets.all(8.0),
              child: Text("Already have an account",style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            }, child: Text('SignIn',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffee2562),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(10)
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40,),
                Text('HABITABLE',style: GoogleFonts.lemon(fontSize: 50,color: Colors.white),),
                SizedBox(height: 40,),
                Container(
                  width: 412,
                  height: 629,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(92),
                        topRight: Radius.circular(92),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0,4.0),
                          blurRadius: 5.0,
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Column(
                        children: [
                          Text("GET STARTED",style: GoogleFonts.lemon(fontSize: 30,color: Color(0xff1f3751),)),
                          SizedBox(height: 10,),
                          Text('Free Forever',style: GoogleFonts.merriweather(fontSize: 14,color: Color(0xff1f3751)),),
                          Center(
                            child: Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Padding(padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _emailController,
                                      style: GoogleFonts.merriweather(color: Color(0xff1f3751)),
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xff1f3751)),
                                        ),
                                        hintText: 'Email',
                                      ),
                                      validator: (value) {
                                        if(value==null || value.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Padding(padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      obscureText: _isObsecure,
                                      controller: _passwordController,
                                      style: GoogleFonts.merriweather(color: Color(0xff1f3751)),
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(_isObsecure?Icons.visibility : Icons.visibility_off),
                                          onPressed: togglePassWordVisibility,
                                        ),
                                        labelText: 'Password',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xff1f3751)),
                                        ),
                                        hintText: 'password',
                                      ),
                                      validator: (value) {
                                        if(value==null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 40,),
                                  Center(
                                    child: Container(
                                      width: 200,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          // if(_formkey.currentState!.validate()){
                                          // };
                                          signup(_emailController.text.toString(), _passwordController.text.toString());
                                        },style: ElevatedButton.styleFrom(
                                          primary: Color(0xffee2562),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          )
                                      ), child: Text('Login',style: GoogleFonts.merriweather(color: Colors.white,fontSize: 15),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Center(child: Text('Or Sign Up With',style: GoogleFonts.merriweather(color: Colors.grey,fontSize: 15),)),
                                  SizedBox(height: 40,),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 150),
                                      child: Row(
                                        children: [
                                          TextButton(onPressed: () async{
                                            final GoogleSignIn gsignin = GoogleSignIn();
                                            try {
                                              final GoogleSignInAccount? googlesigninaccount = await gsignin.signIn();
                                              if(googlesigninaccount != null){
                                                final GoogleSignInAuthentication gsigninauth = await googlesigninaccount.authentication;
                                                final AuthCredential credential = GoogleAuthProvider.credential(
                                                  idToken: gsigninauth.idToken,
                                                  accessToken: gsigninauth.accessToken,
                                                );
                                                await firebaseauth.signInWithCredential(credential).then((value) {
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                                                });
                                              } else {
                                                showDialog(context: context, builder: (BuildContext context) =>
                                                    AlertDialog(
                                                      title: Text('SignUp',style: GoogleFonts.merriweather(color: Colors.white),),
                                                      backgroundColor: Color(0xff1f3751),
                                                      content: SingleChildScrollView(
                                                        child: ListBody(
                                                          children: [
                                                            Text('Something went wrong please try again',style: GoogleFonts.merriweather(color: Colors.white),),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(onPressed: (){
                                                          Navigator.of(context).pop();
                                                        }, child: Text('OK',style: GoogleFonts.merriweather(color: Colors.white),))
                                                      ],
                                                    ));
                                              }
                                            }
                                            on FirebaseAuthException catch(ex){
                                              return showDialog(context: context, builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text('SignUp',style: GoogleFonts.merriweather(color: Colors.white),),
                                                    backgroundColor: Color(0xff1f3751),
                                                    content: SingleChildScrollView(
                                                      child: ListBody(
                                                        children: [
                                                          Text(ex.code.toString(),style: GoogleFonts.merriweather(color: Colors.white),),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(onPressed: (){
                                                        Navigator.of(context).pop();
                                                      }, child: Text('OK',style: GoogleFonts.merriweather(color: Colors.white),))
                                                    ],
                                                  ));


                                            }
                                          }, child: Row(
                                            children: [
                                              Icon(EvaIcons.google,color: Colors.black,),
                                              SizedBox(width: 10,),
                                              Text('Google',style: GoogleFonts.merriweather(color: Colors.black,fontSize: 15),),
                                            ],
                                          ),

                                            style: TextButton.styleFrom(
                                                side: BorderSide(
                                                    color: Colors.black
                                                ),
                                                primary: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                )

                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

      );
  }
}
