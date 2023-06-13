import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectndc/app_components/colour.dart';
import 'package:projectndc/app_components/device_configuration.dart';
import 'package:projectndc/user_views/app_loginpage.dart';
import 'package:projectndc/widgets/Custom_Button.dart';
import 'package:projectndc/widgets/Cutsom_Password_Textfield.dart';
import 'package:projectndc/widgets/custom_msg_snackbar.dart';
import '../widgets/Custom_Textfield.dart';
import '../widgets/FrostedGlass.dart';
import 'login.dart';


class SignUpForm extends StatefulWidget {
  final String userEmail;
  final String userId;
  const SignUpForm({Key? key, required this.userEmail, required this.userId}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final pass1 = TextEditingController();
  final pass2 = TextEditingController();
  final passoutYearcontroller = TextEditingController();

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
              glassHeight: 75*SizeConfig.heightmultiplier,
              glassRadius: 2*SizeConfig.heightmultiplier,
              glassChild: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                        Text("Enter Details", style: TextStyle(fontSize: 3*SizeConfig.heightmultiplier),),
                        Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: CustomTextfield(
                            textfield_isdigits: true,
                            maxLength: 4,
                            textfield_width: 70* SizeConfig.widthmultiplier,
                            textfield_text_colour: Colour.BLUE_TEXT2,
                            icon_details: Icons.calendar_month,
                            opacity: 0.4,
                            textfield_text: "Year of passout",
                            textController: passoutYearcontroller,
                            textfield_colour: Colour.BLUE_BACKGROUND,
                            onTap: () async{
                              DateTime _selectedDate = DateTime.now();
                              showDialog(context: context, builder:(BuildContext context){
                                return AlertDialog(
                                  content: SizedBox(
                                    width: 300,
                                    height: 300,
                                    child: YearPicker(
                                      firstDate: DateTime(DateTime.now().year - 100, 1),
                                      lastDate: DateTime.now(),
                                      initialDate: DateTime.now(),
                                      // save the selected date to _selectedDate DateTime variable.
                                      // It's used to set the previous selected date when
                                      // re-showing the dialog.
                                      selectedDate: _selectedDate,
                                      onChanged: (DateTime dateTime) {
                                        // close the dialog when year is selected.
                                        setState(() {
                                          passoutYearcontroller.text = DateFormat('yyyy').format(dateTime);
                                        });
                                        Navigator.pop(context);

                                        // Do something with the dateTime selected.
                                        // Remember that you need to use dateTime.year to get the year
                                      },
                                    ),
                                  ),
                                );
                              });




                            },
                          ),
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

