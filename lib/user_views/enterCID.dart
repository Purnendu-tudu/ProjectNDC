import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectndc/user_views/app_loginpage.dart';
import 'package:projectndc/widgets/Custom_Button.dart';
import 'package:projectndc/widgets/Custom_Textfield.dart';
import 'package:projectndc/widgets/FrostedGlass.dart';
import '../app_components/device_configuration.dart';
import '../app_components/colour.dart';
import '../app_components/app_constants.dart';
import '../widgets/custom_msg_snackbar.dart';
import 'enterPass.dart';
import 'otp_field.dart';

class EnterCid extends StatefulWidget {
  const EnterCid({Key? key}) : super(key: key);

  @override
  State<EnterCid> createState() => _EnterCidState();
}

class _EnterCidState extends State<EnterCid> {

  final collegeidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.push(context, CupertinoPageRoute(builder: (context) => const LoginPage()));
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
                glassHeight: 50*SizeConfig.heightmultiplier,
                glassRadius: 2*SizeConfig.heightmultiplier,
                glassChild: SingleChildScrollView(
                  child: SafeArea(
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4*SizeConfig.heightmultiplier,
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
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          Text(Texts.t9,
                            style: TextStyle(
                                fontSize: 3*SizeConfig.heightmultiplier,
                                color: Colour.BLUE_TEXT2,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Kanit'
                            ),
                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          CustomTextfield(
                            textfield_isdigits: true,
                            opacity: 0.2,
                            textfield_colour: Colour.BLUE_BACKGROUND,
                            textfield_text: "College ID",
                            textfield_width: 70*SizeConfig.widthmultiplier,
                            icon_details: Icons.badge_outlined,
                            textController: collegeidController,
                          ),
                          SizedBox(
                            height: 5*SizeConfig.heightmultiplier,
                          ),
                          CustomButton(button_text: Texts.t10, button_width: 25*SizeConfig.heightmultiplier, onClick: ()
                          {
                            if(collegeidController.text==''){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: CustomSnackMessage(
                                    messageIcon: Icons.error_outline,
                                    messageTitle: "College ID required",
                                    messageBody: "Enter your College ID for verification",
                                    color: Colors.red),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: Duration( milliseconds: 3000),
                              ));
                            }
                            else {
                              Navigator.push(context, CupertinoPageRoute(
                                  builder: (context) => const OTPfield()));
                            }
                          }),
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

