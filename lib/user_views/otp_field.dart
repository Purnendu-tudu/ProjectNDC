import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectndc/app_components/colour.dart';
import 'package:projectndc/widgets/Custom_Button.dart';
import '../app_components/device_configuration.dart';
import '../app_components/app_constants.dart';
import '../widgets/Custom_Textfield.dart';
import '../widgets/Cutsom_Password_Textfield.dart';
import '../widgets/FrostedGlass.dart';
import 'enterCID.dart';
import 'enterPass.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


class OTPfield extends StatefulWidget {
  const OTPfield({Key? key}) : super(key: key);

  @override
  State<OTPfield> createState() => _OTPfieldState();
}

class _OTPfieldState extends State<OTPfield> {
  String email = "kha*******na@gmail.com";
  String Otp="";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        showDialog(context: context, builder: (context){
          return Dialog(

            child: Container(
              height: 15*SizeConfig.heightmultiplier,
              width: 60*SizeConfig.widthmultiplier,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Are You Sure?", style: TextStyle(fontFamily: 'Kanit',fontSize: 2.5*SizeConfig.heightmultiplier),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(button_text: "Yes", button_width: 18*SizeConfig.widthmultiplier, onClick: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => const EnterCid()));
                      }),
                      CustomButton(button_text: "No", button_width: 18*SizeConfig.widthmultiplier, onClick: (){
                        Navigator.of(context).pop();
                      })
                    ],
                  )
                ],
              ),
            ),
          );
        }
        );
        return false;
      },
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/b4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: FrostedGlass(
              glassWidth: 90*SizeConfig.widthmultiplier,
              glassHeight: 65*SizeConfig.heightmultiplier,
              glassRadius: 5*SizeConfig.heightmultiplier,
              glassChild: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 3*SizeConfig.heightmultiplier,
                        ),
                        //to keep icon
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            height: 12*SizeConfig.heightmultiplier,
                            width: 12*SizeConfig.heightmultiplier,

                            decoration: BoxDecoration(
                              color: Colour.SUPER_BACKGROUND_COLOR,
                              borderRadius: BorderRadius.all(Radius.circular(6*SizeConfig.heightmultiplier)),
                            ),

                            child: SizedBox(
                              height: 11*SizeConfig.heightmultiplier,
                              width: 11*SizeConfig.heightmultiplier,
                              child: Image(
                                image: AssetImage('assets/ndc_logo.png'),
                              ),
                            ),

                          ),
                        ),
                        SizedBox(
                          height: 4*SizeConfig.heightmultiplier,
                        ),
                        Text(
                          "Enter the OTP that is sent in your email : "+email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 2.5*SizeConfig.heightmultiplier
                          ),
                        ),
                        SizedBox(
                          height: 4*SizeConfig.heightmultiplier,
                        ),
                        //to get input of otp
                        OtpTextField(
                          numberOfFields: 6,
                          borderColor: Colour.BLUE_BACKGROUND,
                          enabledBorderColor: Colour.BLUE_BACKGROUND,
                          //set to true to show as box or false to show as dash
                          showFieldAsBox: true,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {},
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode){
                            Otp = verificationCode;
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text("Verification Code"),
                                    content: Text('Code entered is $verificationCode'),
                                  );
                                }
                            );
                          }, // end onSubmit
                        ),
                        SizedBox(
                          height: 9*SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(button_text: "Resend", onClick: (){

                            }, button_width: 30*SizeConfig.widthmultiplier,),
                            CustomButton(
                              button_text: "Confirm",
                              onClick: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const EnterPassword()));
                                },
                              button_width: 30*SizeConfig.widthmultiplier,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


