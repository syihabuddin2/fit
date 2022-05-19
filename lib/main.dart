import 'package:firebase_core/firebase_core.dart';
import 'package:fit/bloc/auth/auth_bloc.dart';
import 'package:fit/bloc/gender/gender_bloc.dart';
import 'package:fit/bloc/navbar/navbar_bloc.dart';
import 'package:fit/bloc/profile/profile_bloc.dart';
import 'package:fit/service/login/loginservice.dart';
import 'package:fit/service/profile/profileservice.dart';
import 'package:fit/view/login/login.dart';
import 'package:fit/view/profile/profileform.dart';
import 'package:fit/view/util/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FitApp());
}

class FitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            return AuthBloc(
              loginService: LoginService(),
              profileService: ProfileService(),
            )..add(AppStarted());
          },
        ),
        BlocProvider<NavbarBloc>(
          create: (context) {
            return NavbarBloc()..add(NavbarEvents.Home);
          },
        ),
        BlocProvider<GenderBloc>(
          create: (context) {
            return GenderBloc()..add(GenderEvents.Man);
          },
        ),
        BlocProvider<ProfileBloc>(
          create: (context) {
            return ProfileBloc(
              profileService: ProfileService(),
            )..add(ProfileStarted());
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthInitialState) {
            return LoginPage();
          } else if (state is UnAuthenticatedState) {
            return LoginPage();
          } else if (state is AuthenticatedState) {
            return ProfileFormPage();
          } else if (state is NextToDashboardState) {
            return NavigationPage();
          } else {
            return LoginPage();
          }
        }),
      ),
    );
  }
}
