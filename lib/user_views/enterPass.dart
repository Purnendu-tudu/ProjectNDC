import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectndc/app_components/colour.dart';
import 'package:projectndc/app_components/device_configuration.dart';
import 'package:projectndc/user_views/app_loginpage.dart';
import 'package:projectndc/widgets/Custom_Button.dart';
import 'package:projectndc/widgets/Cutsom_Password_Textfield.dart';
import 'package:projectndc/widgets/custom_msg_snackbar.dart';
import '../widgets/FrostedGlass.dart';
import 'login.dart';

// class EnterPassword extends StatefulWidget {
//   const EnterPassword({Key? key}) : super(key: key);
//
//   @override
//   State<EnterPassword> createState() => _EnterPasswordState();
// }
//
// class _EnterPasswordState extends State<EnterPassword> {
//   final pass1 = TextEditingController();
//   final pass2 = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       backgroundColor: Colour.SUPER_BACKGROUND_COLOR,
//       body: SafeArea(
//         child: Center(
//
//           child: Container(
//             width: 80*SizeConfig.widthmultiplier,  //change
//             height: 60*SizeConfig.heightmultiplier,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colour.SUPER_BACKGROUND_COLOR,
//                 borderRadius: BorderRadius.all(Radius.circular(5*SizeConfig.heightmultiplier)),
//
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colour.SUPER_GREY,
//                     blurRadius: 10,
//                     offset: const Offset(10.0, 10.0,),
//                   ),
//                   BoxShadow(
//                     color: Colour.BACKGROUND_COLOR,
//                     blurRadius: 10,
//                     offset: const Offset(-10.0, -10.0,),
//                   ),],
//               ),
//
//               child: SingleChildScrollView(
//                 child: Column(
//                 children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 5*SizeConfig.heightmultiplier),
//                   child: Container(
//                     height: 10*SizeConfig.heightmultiplier,
//                     width: 10*SizeConfig.heightmultiplier,
//
//                     decoration: BoxDecoration(
//                       color: Colour.SUPER_BACKGROUND_COLOR,
//                       borderRadius: BorderRadius.all(Radius.circular(5*SizeConfig.heightmultiplier)),
//
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colour.SUPER_GREY,
//                           blurRadius: 10,
//                           offset: const Offset(10.0, 10.0,),
//                         ),
//                         BoxShadow(
//                           color: Colour.BACKGROUND_COLOR,
//                           blurRadius: 10,
//                           offset: const Offset(-10.0, -10.0,),
//                         ),],
//
//                     ),
//
//                       child: Center(
//                         child: SizedBox(
//                           height: 15*SizeConfig.heightmultiplier,
//                           width: 15*SizeConfig.widthmultiplier,
//                           child: Image(
//                             image: AssetImage('assets/ndc_logo.png'),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 4*SizeConfig.heightmultiplier),
//                     child: Text("Enter Password",
//                       style: TextStyle(fontSize: 4*SizeConfig.heightmultiplier, color: Colour.BLUE_TEXT),
//                     ),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 1*SizeConfig.heightmultiplier),
//                     child: CustomPasswordTextfield(passwordController: pass1, textfield_colour: Colour.SUPER_BACKGROUND_COLOR,),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
//                     child: Text("Confirm Password",
//                       style: TextStyle(fontSize: 4*SizeConfig.heightmultiplier, color: Colour.BLUE_TEXT),
//                     ),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 1*SizeConfig.heightmultiplier),
//                     child: CustomPasswordTextfield(passwordController: pass2, textfield_colour: Colour.SUPER_BACKGROUND_COLOR,),
//                   ),
//
//                   Padding(padding: EdgeInsets.only(top: 6*SizeConfig.heightmultiplier),
//                     child: CustomButton(button_width: 40*SizeConfig.widthmultiplier, button_text: "Submit", onClick: ()
//                     {
//                       if (pass1.text == pass2.text){
//                         print("yes, same passwords");
//                         Navigator.push(context, CupertinoPageRoute(builder: (context) => const Login()));
//                       }
//                       else{
//                         print("Diff passwords");
//                       }
//                     }),
//                   )
//
//
//
//                   ],),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class EnterPassword extends StatefulWidget {
  const EnterPassword({Key? key}) : super(key: key);

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

class _EnterPasswordState extends State<EnterPassword> {

  final pass1 = TextEditingController();
  final pass2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
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
              glassWidth: 80*SizeConfig.widthmultiplier,
              glassHeight: 60*SizeConfig.heightmultiplier,
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
                          height: 2.5*SizeConfig.heightmultiplier,
                        ),
                        Text("Enter Password", style: TextStyle(fontSize: 3*SizeConfig.heightmultiplier),),
                        SizedBox(
                          height: 2.5*SizeConfig.heightmultiplier,
                        ),
                        CustomPasswordTextfield(passwordController: pass1, textfield_colour: Colour.BLUE_BACKGROUND, opacity: 0.2, icon_hidden: true,),
                        SizedBox(
                          height: 3*SizeConfig.heightmultiplier,
                        ),
                        CustomPasswordTextfield(passwordController: pass2, textfield_colour: Colour.BLUE_BACKGROUND, opacity: 0.2, textfield_text: "Confirm Password", icon_hidden: true,),
                        SizedBox(
                          height: 6*SizeConfig.heightmultiplier,
                        ),


                        //to get input of otp
                        CustomButton(button_text: "SUBMIT", onClick: (){

                          if (pass1.text != '' && pass2.text != ''){
                            if (pass1.text == pass2.text){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: CustomSnackMessage(
                                    messageIcon: Icons.lock_clock_outlined,
                                    messageTitle: "Password Confirmed",
                                    messageBody: "Log in to your account",
                                    color: Colors.green),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: Duration( milliseconds: 2500),
                              ));

                              Navigator.push(context, CupertinoPageRoute(builder: (context) => const LoginPage()));
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: CustomSnackMessage(
                                    messageIcon: Icons.lock_clock_outlined,
                                    messageTitle: "Different Passwords",
                                    messageBody: "Enter the same Passwords",
                                    color: Colors.red),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: Duration( milliseconds: 2500),
                              ));
                            }
                          }

                          else if (pass1.text == '' || pass2.text == ''){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: CustomSnackMessage(
                                  messageIcon: Icons.error_outline,
                                  messageTitle: "Password not entered",
                                  messageBody: "Enter the same Passwords inside both the fields",
                                  color: Colors.purple),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              duration: Duration( milliseconds: 2500),
                            ));
                          }


                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );;
  }
}

