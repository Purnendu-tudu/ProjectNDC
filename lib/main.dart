import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:projectndc/Sample.dart';
import 'package:projectndc/user_views/bodypage.dart';
import 'package:projectndc/user_views/app_forms_view/app_course_panel.dart';
import 'package:projectndc/user_views/enterCID.dart';
import 'package:projectndc/user_views/enterPass.dart';
import 'package:projectndc/user_views/app_forms_view/app_exams_panel.dart';
import 'package:projectndc/user_views/app_forms_view/app_job_panel.dart';
import 'package:projectndc/user_views/login.dart';
import 'package:projectndc/user_views/home.dart';
import 'package:projectndc/user_views/app_loginpage.dart';
import 'package:projectndc/user_views/profile.dart';
import 'package:projectndc/user_views/selectOption.dart';
import 'package:projectndc/user_views/timeline.dart';
import 'package:projectndc/widgets/Custom_Button.dart';
import 'package:projectndc/widgets/Custom_DropList.dart';
import 'package:projectndc/widgets/Custom_Textfield.dart';
import 'package:projectndc/widgets/FrostedGlass.dart';
import 'user_views/otp_field.dart';
import 'app_components/device_configuration.dart';
import 'user_views/selectAdd.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 300));
  await FlutterDownloader.initialize(
      debug: true
  );
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  //   runApp(MyApp());
  // });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/loginpage',
                  routes: {
                    '/loginpage' : (context) => const LoginPage(),               '/selectOption' : (context) => const SelectOption(),
                    '/exams_panel' : (context) => const Exam(),
                    '/job_panel' : (context) => const Job(),
                    '/course_panel' : (context) => const Course(),
                    '/enterCID' : (context) => const EnterCid(),
                    '/otp_field' : (context) => const OTPfield(),
                    '/enterPass' : (context) => const EnterPassword(),
                    '/profile' : (context) => const Profile(),
                    '/timeline' : (context) => const User_timeline(),
                    '/bodypage' : (context) => const Bodypage(),
                    // '/Custom_DropList' : (context) => CustomDroplist(),
                    // '/Custom_Textfield' : (context) => CustomTextfield()
                  },
              );
            },
        );
      },
    );
  }
}