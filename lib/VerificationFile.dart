
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nber_flutter/DashBoardFile.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:connectivity/connectivity.dart';
import 'LoginApi.dart';
import 'LoginModel.dart';

import 'MyColors.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'UserRegisterFile.dart';
class VerificationFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  VerificationState();
  }
}
class VerificationState extends State<VerificationFile>
{
  TextEditingController mobilenumbercontroller;
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  LoginApi _guestUserApi;
  ProgressDialog progressDialog;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobilenumbercontroller=new TextEditingController();
    _guestUserApi=new LoginApi();
    progressDialog=new ProgressDialog(context,type: ProgressDialogType.Normal);
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(child: Stack(
          children: <Widget>[

        new Column(
        children:<Widget>[
            Container(
                margin: const EdgeInsets.only(top:40,left: 10,bottom: 10,right:10),

                child: Align(alignment: Alignment.topLeft,
                    child: InkWell(
                      child: Image.asset('images/yellow_logo.png',height: 20,width: 20,)  ,
                      onTap:() {
                        Toast.show('Back',context,duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                      },



                    ) ))

            ,



              new Container(margin: const EdgeInsets.only(left:10),
                child: Align( alignment: Alignment.topLeft,   child: Text("Enter phone number for verification",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16 ),),
                )

              ),
          new Container(
            margin: const EdgeInsets.only(left:10,top: 15),

              child: Align( alignment: Alignment.topLeft, child:Text("This number will be used to contact you and communicate all ride related details.",style: TextStyle(color: Colors.black87,fontSize: 9 ),),

              ),







          ),
          //////  THIS CONTAINER FOR NUMBER
          Padding(padding: EdgeInsets.only(top: 20.0)),
          ////// FOR PASSWORD

          new Container(   margin: const EdgeInsets.only(left: 10,right: 10),alignment: Alignment.center,padding: const EdgeInsets.all(10),
                    decoration: new BoxDecoration(color: MyColors.white,border: Border(bottom: BorderSide(color: Colors.blue,
                      width: 1.0,)),),



                    child:new  Row(children: <Widget>[
                      Expanded(flex: 1,child: Image.asset('images/yellow_logo.png',width: 20,height: 20,),),

                      Expanded(flex: 1, child:
                      Text('+91',textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold) ),
                      ),
                      Expanded(flex: 10,child: TextFormField(controller: mobilenumbercontroller,inputFormatters: [LengthLimitingTextInputFormatter(10),], textAlign: TextAlign.start,  keyboardType: TextInputType.phone,obscureText: false,style: TextStyle(color: Colors.black,fontSize: 16), decoration: new InputDecoration(fillColor: Colors.white,filled: true, border: new OutlineInputBorder(borderRadius: new BorderRadius.circular(20.00),borderSide: new BorderSide(color: Colors.white)),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(20.00)),enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),),contentPadding: EdgeInsets.only(left:10,top:0,right:10,bottom:0),hintText: "Enter Mobile"
                      )),
                      ),
                      Expanded(flex: 1,child: Image.asset('images/yellow_logo.png',width: 20,height: 20,),),

                    ]))





        ],

            )
, Align( alignment: Alignment.bottomCenter,
           child: new Container(


              margin: const EdgeInsets.only(left: 55,right:55,top:15) ,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: Offset(4, 4),
                      blurRadius: 8.0),
                ],
              ),

                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: ()
                    {
                     // _callvalidation();
                      //////
                   /* Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(builder: (ctxt) => new DashBoardFile()),
                      );*/
                  Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(builder: (ctxt) => new UserRegisterFile()),
                      );


                      /////


                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )


          ],





        )
    ));
  }




  void _callvalidation() async {
    String mobilenumber=mobilenumbercontroller.text.toString();
    if(mobilenumber.length==0||mobilenumber.isEmpty||mobilenumber==" "||mobilenumber==null) {
      Toast.show("Enter Mobile Number", context, duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
    }
    else if(mobilenumber.length<10)
    {
      Toast.show("Enter Correct Mobile Number", context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
    }
    else{
      var connectivityResult = await  Connectivity().checkConnectivity();
      phoneNo="+91"+mobilenumber;
      if (connectivityResult == ConnectivityResult.mobile) {
        _CallFireBaseandCHeckUserAuthenticatiobn();
      }

      else if (connectivityResult == ConnectivityResult.wifi) {
        _CallFireBaseandCHeckUserAuthenticatiobn();
      }
      else
      {
        Toast.show("Network Not Available. ", context, duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM);
      }

    }

  }
////// THIS METHOD FOR CHECK MOBILE NO ATHENTICATION AND REDIRECT TO HOME NO
  Future<void> _CallFireBaseandCHeckUserAuthenticatiobn() async
  {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {

      });
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
          smsOTPSent,
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString());
            bool verify=false;
           //////////// _callapiforlogin();









          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
            Toast.show('${exceptio.message}', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
          });
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog( backgroundColor: MyColors.yellow,
            title:new Container( decoration: BoxDecoration(color: MyColors.yellow), child: Text('Enter Verification Code'),),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMessage != ''
                    ? Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      _callapiforlogin();
                      Toast.show('Login successfully', context,duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
                    }
                    else {
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user = (await _auth.signInWithCredential(credential)) as FirebaseUser;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      _callapiforlogin();
    }
    catch (e)
    {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }



















   _callapiforlogin() async {
     var connectivityResult = await Connectivity().checkConnectivity();
     if (connectivityResult == ConnectivityResult.mobile) {
      callapiforlogin_sec();
     }
     else if (connectivityResult == ConnectivityResult.wifi) {
       callapiforlogin_sec();
     }
     else
     {
       Toast.show("Network Not Available. ", context, duration: Toast.LENGTH_SHORT,
           gravity: Toast.BOTTOM);
     }


  }

  Future<void> callapiforlogin_sec() async {

    // ignore: new_with_undefined_constructor_default
    //LoginModel results = new LoginModel();
    progressDialog.show();
String name= mobilenumbercontroller.text.toString();
    LoginModel results= await _guestUserApi.search(name);

    String names=results.data.name;


    if(results.status==200){

      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setBool("LOGIN", true);
      sharedPreferences.setString("USERNAME", name);
      // sharedPreferences.commit();

      progressDialog.hide();
    //  Navigator.pushReplacement(context, new MaterialPageRoute(builder:  (ctxt) => new HomeFile()));
      Toast.show('Wel Come '+name, context, duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
    }
    else{
      progressDialog.hide();
      Toast.show(results.message, context, duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
    }







  }
}