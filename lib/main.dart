import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gchat/firebase_options.dart';
import 'package:gchat/viewmodels/auth_view_model.dart';
import 'package:gchat/viewmodels/bottomNav_model.dart';
import 'package:gchat/viewmodels/profile_model.dart';
import 'package:gchat/views/auth/login.dart';
import 'package:gchat/views/auth/welcome_Screen.dart';
import 'package:gchat/views/bottombar.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomnavModel(),
          //
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileModel(),
          //
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2C57A6)),
          useMaterial3: true,
        ),
        home: localStorage.getItem('onboard') == 'true'
            ? localStorage.getItem('loggedin') == 'true'
                ? BottomBar()
                : Login()
            : const WelcomeScreen(),
      ),
    );
  }
}
