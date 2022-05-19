import 'package:fit/bloc/auth/auth_bloc.dart';
import 'package:fit/view/profile/profileform.dart';
import 'package:fit/view/util/appbar.dart';
import 'package:fit/view/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {

  late double titleHeight,
      subTitleHeight,
      headerHeight,
      usernameHeight,
      usernameWidth,
      passwordHeight,
      passwordWidth,
      buttonHeight,
      buttonWidth,
      copyrightHeight;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? username, password;

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;

    var appBar = TopBar();
    double appBarHeight = appBar.preferredSize.height;

    heightSize =
        MediaQuery.of(context).size.height - statusBarHeight - appBarHeight;
    widthSize = MediaQuery.of(context).size.width;

    shortestSide = MediaQuery.of(context).size.shortestSide;
    isMobile = shortestSide < 600.0;
    orientation = MediaQuery.of(context).orientation;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          SmartDialog.showToast(state.error.toString());
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print("AuthState login view: ${state}");
          if (state is AuthenticatedState) {
            return ProfileFormPage();
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: body(context, orientation),
          );
        },
      ),
    );
  }

  body(context, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      //Title size
      titleHeight = (isMobile == true) ? heightSize * 0.15 : heightSize * 0.10;

      //Sub Title size
      subTitleHeight =
          (isMobile == true) ? heightSize * 0.05 : heightSize * 0.10;

      //Header size
      headerHeight = (isMobile == true) ? heightSize * 0.30 : heightSize * 0.10;

      //Username size
      usernameHeight =
          (isMobile == true) ? heightSize * 0.10 : heightSize * 0.10;
      usernameWidth = (isMobile == true) ? widthSize * 0.80 : widthSize * 0.10;

      //Password size
      passwordHeight =
          (isMobile == true) ? heightSize * 0.10 : heightSize * 0.10;
      passwordWidth = (isMobile == true) ? widthSize * 0.80 : widthSize * 0.10;

      //Button size
      buttonHeight = (isMobile == true) ? heightSize * 0.06 : heightSize * 0.06;
      buttonWidth = (isMobile == true) ? widthSize * 0.60 : widthSize * 0.10;

    } else {
      //Title size
      titleHeight = (isMobile == true) ? heightSize * 0.15 : heightSize * 0.10;

      //Sub Title size
      subTitleHeight =
          (isMobile == true) ? heightSize * 0.15 : heightSize * 0.10;

      //Header size
      headerHeight = (isMobile == true) ? heightSize * 0.70 : heightSize * 0.10;

      //Username size
      usernameHeight =
          (isMobile == true) ? heightSize * 0.20 : heightSize * 0.10;
      usernameWidth = (isMobile == true) ? widthSize * 0.50 : widthSize * 0.10;

      //Password size
      passwordHeight =
          (isMobile == true) ? heightSize * 0.20 : heightSize * 0.10;
      passwordWidth = (isMobile == true) ? widthSize * 0.50 : widthSize * 0.10;

      //Button size
      buttonHeight = (isMobile == true) ? heightSize * 0.13 : heightSize * 0.10;
      buttonWidth = (isMobile == true) ? widthSize * 0.30 : widthSize * 0.30;
    }

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ListView(
          children: [
            Column(
              children: <Widget>[
                title(titleHeight),
                subTitle(subTitleHeight),
                headerSection(headerHeight),
                usernameSection(usernameHeight, usernameWidth),
                passwordSection(passwordHeight, passwordWidth),
                buttonSection(context, buttonHeight, buttonWidth),
              ],
            ),
          ],
        )
      ],
    );
  }

  Container title(titleHeight) {
    return Container(
      height: titleHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: orientation == Orientation.portrait
                ? titleHeight * 0.35
                : titleHeight * 0.70,
            child: const FittedBox(
              child: Text(
                "Fit App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox subTitle(subTitleHeight) {
    return SizedBox(
      height: subTitleHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: subTitleHeight * 0.40,
            child: const FittedBox(
              child: Text(
                "Didalam badan yang sehat, terdapat jiwa yang kuat.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox headerSection(headerHeight) {
    return SizedBox(
      height: headerHeight,
      child: Center(
        child: SizedBox(
          height: headerHeight * 0.95,
          child: Lottie.asset('lib/assets/icon/weights-lift.json'),
        ),
      ),
    );
  }

  SizedBox usernameSection(usernameHeight, usernameWidth) {
    return SizedBox(
      height: usernameHeight,
      width: usernameWidth,
      child: Center(
        child: TextField(
          obscureText: false,
          controller: _usernameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            labelText: 'Username',
          ),
        ),
      ),
    );
  }

  SizedBox passwordSection(passwordHeight, passwordWidth) {
    return SizedBox(
      height: passwordHeight,
      width: passwordWidth,
      child: Center(
        child: TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            labelText: 'Password',
          ),
        ),
      ),
    );
  }

  Container buttonSection(context, buttonHeight, buttonWidth) {
    username = _usernameController.text;
    password = _passwordController.text;
    return Container(
      height: buttonHeight,
      width: buttonWidth,
      margin: orientation == Orientation.portrait
          ? EdgeInsets.only(top: buttonHeight * 0.90)
          : EdgeInsets.only(
              top: buttonHeight * 0.60, bottom: buttonHeight * 0.95),
      child: ElevatedButton(
        child: SizedBox(
          height: buttonHeight * 0.45,
          child: const FittedBox(
            child: Text('Login'),
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          elevation: MaterialStateProperty.all(10),
          backgroundColor: MaterialStateProperty.all(primaryColor),
        ),
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(
            LoginPressButton(
              email: username,
              password: password,
            ),
          );
        },
      ),
    );
  }
}
