import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectndc/app_components/device_configuration.dart';
import 'package:projectndc/app_components/colour.dart';
import 'package:projectndc/app_controllers/login_controller.dart';
import 'package:projectndc/widgets/FrostedGlass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_components/app_constants.dart' as constants;
import '../app_config/loading.dart';
import '../app_models/login_result_model.dart';
import '../widgets/Custom_Button.dart';
import '../widgets/Custom_Textfield.dart';
import '../widgets/Cutsom_Password_Textfield.dart';
import '../widgets/custom_msg_snackbar.dart';
import 'bodypage.dart';
import 'enterCID.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  bool _isButtonClicked = false;
  var loadingObj = Loading();

  final collegeidController = TextEditingController();
  final passwordController = TextEditingController();
  SharedPreferences? sharedPreferences;

  void sharedData() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }


  getLoginData(String userEmail, String userPassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LoginController loginController = LoginController();
    LoginResultModel response = await loginController.tryLogging(userEmail,userPassword);
    if(response.status == true){
      print("Success");
      print(response.data?.userToken);
      sharedPreferences.setString("token", response.data?.userToken??'');
      sharedPreferences.setString("userId", response.data?.userId??'');
      if(_isChecked){
        sharedPreferences.setBool('rememberme', true);
      }else{
        sharedPreferences.setBool('rememberme', false);
      }
      Future.delayed(Duration(microseconds: 92),(){
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Bodypage()));
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: CustomSnackMessage(
            messageIcon: Icons.verified_outlined,
            messageTitle: "Successful",
            messageBody: "Successfully logged in",
            color: Colors.green),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration( milliseconds: 3000),
      ));
    }else{
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: CustomSnackMessage(
            messageIcon: Icons.error_outline,
            messageTitle: "Failed",
            messageBody: "Wrogn userid or password",
            color: Colors.redAccent),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: Duration( milliseconds: 3000),
      ));
    }
  }


  // getRemeberMeEvent() async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   if(sharedPreferences.getBool("rememberme")!){
  //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const Bodypage()), (Route<dynamic> route) => false);
  //   }else{
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    sharedData();
    super.initState();
    // getRemeberMeEvent();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    collegeidController.clear();
    passwordController.clear();
    super.dispose();
  }


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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/b2.jpg'),
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
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
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
                                child: const Image(
                                  image: AssetImage('assets/ndc_logo.png'),
                                ),
                              ),

                            ),
                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          //2 texts
                          Text(constants.Texts.text2,
                            style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier, fontFamily: 'Kanit'),
                          ),
                          Text(constants.Texts.text3,
                            style: TextStyle(fontSize: 3*SizeConfig.heightmultiplier, fontFamily: 'Kanit'),
                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          //to get input of CID
                          CustomTextfield(
                            textfield_width: 70* SizeConfig.widthmultiplier,
                            textfield_isdigits: true,
                            opacity: 0.4,
                            textfield_text: constants.Texts.text4,
                            icon_details: Icons.account_circle_outlined,
                            textController: collegeidController,
                            textfield_colour: Colour.SUPER_BACKGROUND_COLOR,

                          ),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          //to get input of Password
                          CustomPasswordTextfield(
                            textfield_width: 70* SizeConfig.widthmultiplier,
                            passwordController: passwordController,
                            textfield_colour: Colour.SUPER_BACKGROUND_COLOR,
                            opacity: 0.4,),
                          SizedBox(
                            height: 2*SizeConfig.heightmultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      value: _isChecked,
                                      onChanged: (bool? value){
                                        setState(() {
                                          _isChecked = value!;
                                        });
                                        print(_isChecked);
                                      }
                                  ),
                                  Text(constants.Texts.REMEM_ME , style:TextStyle(
                                      fontSize: 2*SizeConfig.heightmultiplier,
                                      color: Colour.PRIMARY_COLOR,
                                      fontFamily: 'Kanit'
                                  ),),
                                ],
                              ),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EnterCid(buttonName: 'forgotPassword')));
                                },
                                child: Text(constants.Texts.FORGOR_PASS_TEXT,
                                  style: TextStyle(
                                      fontSize: 2*SizeConfig.heightmultiplier,
                                      color: Colour.BLUE_TEXT2,
                                      fontFamily: 'Kanit'
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1*SizeConfig.heightmultiplier,
                          ),
                          CustomButton(button_text: constants.Texts.text1, onClick: (){
                            print(collegeidController.text);
                            print(passwordController.text);
                            // if (collegeidController.text == "20200785" && passwordController.text == "ranjana1234"){
                            //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            //     content: CustomSnackMessage(
                            //         messageIcon: Icons.check_circle_outline_rounded,
                            //         messageTitle: "Log in successful",
                            //         messageBody: "Welcome to Narasinha Dutt College",
                            //         color: Colors.green),
                            //     behavior: SnackBarBehavior.floating,
                            //     backgroundColor: Colors.transparent,
                            //     elevation: 0,
                            //     duration: Duration( milliseconds: 4000),
                            //   ));
                            //   Navigator.push(context, CupertinoPageRoute(builder: (context) => const Bodypage()));
                            // }
                            // else{
                            //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            //     content: CustomSnackMessage(
                            //         messageIcon: Icons.clear,
                            //         messageTitle: "Log in unsuccessful",
                            //         messageBody: "Check your College ID or Password",
                            //         color: Colors.red),
                            //     behavior: SnackBarBehavior.floating,
                            //     backgroundColor: Colors.transparent,
                            //     elevation: 0,
                            //     duration: Duration( milliseconds: 3000),
                            //   ));
                            // }
                            if(collegeidController.text.isNotEmpty  && passwordController.text.isNotEmpty){
                              loadingObj.showLoadingDialog(context);
                              getLoginData(collegeidController.text.toString(), passwordController.text.toString());


                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: CustomSnackMessage(
                                          messageIcon: Icons.warning_amber_outlined,
                                          messageTitle: "Required",
                                          messageBody: "College Id and Password required",
                                          color: Colors.orangeAccent),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      duration: Duration( milliseconds: 3000),
                                    ));

                            }
                          },),
                          SizedBox(
                            height: 5*SizeConfig.heightmultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(constants.Texts.text7,
                                style: TextStyle(
                                  fontSize: 2*SizeConfig.heightmultiplier,
                                  color: Colour.PRIMARY_COLOR,
                                  fontFamily: 'Kanit'
                                ),
                              ),

                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EnterCid(buttonName: 'signUp')));
                                },
                                child: Text(constants.Texts.text8,
                                  style: TextStyle(
                                    fontSize: 2*SizeConfig.heightmultiplier,
                                    color: Colour.BLUE_TEXT,
                                    fontFamily: 'Kanit'
                                  ),
                                ),
                              ),

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
