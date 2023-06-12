import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectndc/app_components/colour.dart';
import 'package:projectndc/app_components/device_configuration.dart';
import 'package:projectndc/app_controllers/user_profile_controller.dart';
import 'package:projectndc/app_models/app_user_profile_model.dart';
import 'package:projectndc/user_views/selectAdd.dart';
import 'package:projectndc/user_views/selectOption.dart';
import 'package:projectndc/user_views/app_loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/Custom_Button.dart';
import '../widgets/FrostedGlass.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = true;
  bool hasData = true;
  String name   = "Ranjana Khara";
  String cid    = "20200785";
  String degree = "BSc Computer Science";
  String email  = "khararanjanaxxxxxxxxxxxxxxxxxxxx@gmail.com";
  String phone  = "8622855305";
  String gender = "Female";
  String caste  = "General";
  SharedPreferences? sharedPreferences;

  void getSharedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  getUserProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("token"));
    UserProfileResultController userProfileResultController = UserProfileResultController();
    UserProfileResultModel result = await userProfileResultController.getUserProfileResult(sharedPreferences.getString("token")??'');
    print(result.data?.userName);
    print(result.data?.userId);
    print(result.data?.userDegree);
    print(result.data?.userGender);
    print(result.data?.userCaste);
    print(result.data?.userPhonenumber);
    print(result.data?.userEmail);
    print(result.status);
    if(result.status == true){
      setState(() {
        name     = result.data!.userName??'';
        cid      = result.data!.userId??'';
        degree   = result.data!.userDegree??'';
        email    = (result.data?.userEmail == ''?'No Email Found':result.data?.userEmail)!;
        phone    = result.data!.userPhonenumber??'';
        gender   = result.data!.userGender??'';
        caste    = result.data!.userCaste??'';
        isLoading = false;        
      });
    }else{
      setState(() {
        isLoading = false;
        hasData = false;
      });
    }
    
  }

  @override
  void initState(){
    // TODO: implement initState

    getSharedData();
    getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          //padding: EdgeInsets.only(top: 2*SizeConfig.heightmultiplier),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/b5.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child:Column(
            children: [
              // SizedBox(
              //   height: 4*SizeConfig.heightmultiplier,
              // ),
              //to keep icon
              FrostedGlass(
                glassWidth: 100*SizeConfig.widthmultiplier,
                glassHeight: 10.5*SizeConfig.heightmultiplier,
                // topmargin: 10*SizeConfig.heightmultiplier,
                // bottommargin: 10*SizeConfig.heightmultiplier,
                // sidemargin: 10*SizeConfig.widthmultiplier,
                glassRadius: 0*SizeConfig.heightmultiplier,
                glassChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 11*SizeConfig.heightmultiplier,
                        width: 11*SizeConfig.heightmultiplier,
                        child: const Image(
                          color: Colors.blueAccent,
                          image: AssetImage('assets/ndc_logo.png'),
                        ),
                      ),
                      const SizedBox.shrink(),
                      const SizedBox.shrink(),
                      const SizedBox.shrink(),
                      const SizedBox.shrink(),
                      const SizedBox.shrink(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (Route<dynamic> route) => false);
                              sharedPreferences?.clear();
                              },
                            child: Column(
                              children: [
                                const SizedBox(height: 10,),
                                Icon(Icons.logout_rounded, color: Colors.white,size: 10 * SizeConfig.imageSizeMultiplier,),
                                const Text("Log Out", style: TextStyle(fontFamily: 'Kanit', fontSize: 15,color: Colors.white),),
                              ],
                            ),
                          ),
                          SizedBox(width: 5*SizeConfig.widthmultiplier,)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1*SizeConfig.heightmultiplier,
              ),
              FrostedGlass(
                glassWidth: 90*SizeConfig.widthmultiplier,
                glassHeight: 74*SizeConfig.heightmultiplier,
                // topmargin: 10*SizeConfig.heightmultiplier,
                // bottommargin: 10*SizeConfig.heightmultiplier,
                // sidemargin: 10*SizeConfig.widthmultiplier,
                glassRadius: 2*SizeConfig.heightmultiplier,
                glassChild: Container(
                  margin: EdgeInsets.all(2 * SizeConfig.widthmultiplier),
                  child:isLoading?const Center(child: CircularProgressIndicator(),) : hasData? SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3*SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Icon(Icons.account_circle_outlined,size: 4.5*SizeConfig.heightmultiplier),
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ",
                                  style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier, fontFamily: 'Kanit'),
                                ),
                                Text(name,
                                  style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier, fontFamily: 'JosefinSans', color: Colour.BLUE_TEXT2),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2*SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Icon(Icons.badge_outlined,size: 4.5*SizeConfig.heightmultiplier),
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("College ID: ",
                                  style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier, fontFamily: 'Kanit'),
                                ),
                                Text(cid,
                                  style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier, fontFamily: 'JosefinSans', color: Colour.BLUE_TEXT2),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2*SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Icon(Icons.school_outlined,size: 4.5*SizeConfig.heightmultiplier),
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Degree: ",
                                  style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                ),
                                Text(degree,
                                  style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2*SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Icon(Icons.people_alt_outlined,size: 4.5*SizeConfig.heightmultiplier),
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Gender: ",
                                  style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                ),
                                Text(gender,
                                  style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2*SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Icon(Icons.insert_chart_outlined,size: 4.5*SizeConfig.heightmultiplier),
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Caste: ",
                                  style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                ),
                                Text(caste,
                                  style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2*SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Icon(Icons.call,size: 4.5*SizeConfig.heightmultiplier),
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone number: ",
                                  style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                ),
                                Text(phone,
                                  style: TextStyle(fontSize: 2.5*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2*SizeConfig.heightmultiplier,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Icon(Icons.email_outlined,size: 4.5*SizeConfig.heightmultiplier),
                            SizedBox(width: 3*SizeConfig.widthmultiplier),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email: ",
                                    style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),
                                  ),
                                  Text(
                                    email,
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 2.2*SizeConfig.heightmultiplier,fontFamily: 'JosefinSans',color: Colour.BLUE_TEXT2),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 3*SizeConfig.heightmultiplier,
                        ),

                        SizedBox(
                          height: 3*SizeConfig.heightmultiplier,
                        ),
                        Center(child: Text("Add Information",textAlign: TextAlign.center, style: TextStyle(fontSize: 2*SizeConfig.heightmultiplier,fontFamily: 'Kanit'),)),

                        Center(
                          child: TextButton(
                            style: ButtonStyle(

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context) => const SelectOption()));
                            }, child: Icon(Icons.add_circle,size: 8*SizeConfig.heightmultiplier, color: Colors.black26,),
                            ),
                        ),
                      ],
                    ),
                  ):const Text("Unauthorized"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



