import 'package:fit/bloc/auth/auth_bloc.dart';
import 'package:fit/bloc/gender/gender_bloc.dart';
import 'package:fit/view/util/constant.dart';
import 'package:fit/view/util/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({Key? key}) : super(key: key);

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final TextEditingController nameController = TextEditingController();

  String? username, password;

  String? currentGender;

  double? currentHeightBody = 0;

  double? currentWeightBody = 0;

  DateTime selectedDate = DateTime.now();
  String? currentDate;

  @override
  Widget build(BuildContext context) {
    heightSize = MediaQuery.of(context).size.height;
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
          if (state is NextToDashboardState) {
            return NavigationPage();
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: body(context, orientation),
            floatingActionButton: buttonSection(context),
          );
        },
      ),
    );
  }

  body(context, Orientation orientation) {

    responsiveLayout(isMobile, orientation);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ListView(
          children: [
            Column(
              children: <Widget>[
                title(),
                name(),
                dateOfBirth(),
                gender(),
                heightBody(context),
                weightBody(),
              ],
            ),
          ],
        )
      ],
    );
  }

  Container title() {
    return Container(
      height: heightBodyHeight,
      padding: EdgeInsets.only(left: heightBodyHeight * 0.10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              "Give us some basic information",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: heightBodyHeight * 0.20,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container name() {
    return Container(
      height: nameHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: nameHeight * 0.30,
            child: FittedBox(
              child: Text(
                "Name".toUpperCase(),
                style: const TextStyle(color: textColor),
              ),
            ),
          ),
          Container(
            height: nameHeight * 0.60,
            padding: EdgeInsets.only(top: nameHeight * 0.10, left: nameHeight * 0.15, right: nameHeight * 0.15),
            child: TextField(
              obscureText: false,
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                labelText: 'Name',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container dateOfBirth() {
    
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1950),
          lastDate: DateTime(2100));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    currentDate = selectedDate.toLocal().toString().split(' ')[0];

    return Container(
      height: dateOfBirthHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: dateOfBirthHeight * 0.30,
            child: FittedBox(
              child: Text(
                "Date of Birth".toUpperCase(),
                style: const TextStyle(color: textColor),
              ),
            ),
          ),
          Container(
            height: nameHeight * 0.60,
            padding: EdgeInsets.only(top: dateOfBirthHeight * 0.10, left: dateOfBirthHeight * 0.15, right: dateOfBirthHeight * 0.15),
            child: TextField(
              onTap: () {
                _selectDate(context);
              },
              readOnly: true,
              obscureText: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                labelText: 'Date',
                hintText: currentDate,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container gender() {
    int? currentIndex;

    return Container(
      child: BlocBuilder<GenderBloc, GenderState>(
        builder: (context, state) {
          if (state is ManState) {
            currentIndex = state.itemIndex;
            currentGender = "Man";
          }

          if (state is WomanState) {
            currentIndex = state.itemIndex;
            currentGender = "Woman";
          }

          return Container(
            height: genderHeight,
            padding: EdgeInsets.only(left: genderWidth * 0.05, right: genderWidth * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: genderHeight * 0.65,
                    width: genderWidth,
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<GenderBloc>(context).add(GenderEvents.Man);
                      },
                      child: Card(
                        color: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.grey
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            currentIndex == 0 ? 
                            ListTile(
                              leading: Icon(Icons.check_circle,
                                  color: Colors.black, 
                                  size: dashboardCardHeight * 0.20,
                              ),
                            ) :
                            ListTile(
                              leading: Icon(Icons.check_circle,
                                  color: Colors.white, 
                                  size: dashboardCardHeight * 0.20,
                              ),
                            ),
                            SizedBox(
                              height: genderHeight * 0.20,
                              width: genderWidth * 0.20,
                              child: FittedBox(
                                child: Image.asset('lib/assets/icon/man.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: genderHeight * 0.65,
                    width: genderWidth,
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<GenderBloc>(context).add(GenderEvents.Woman);
                      },
                      child: Card(
                        color: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.grey
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            currentIndex == 1 ? 
                            ListTile(
                              leading: Icon(Icons.check_circle,
                                  color: Colors.black, 
                                  size: dashboardCardHeight * 0.20,
                              ),
                            ) :
                            ListTile(
                              leading: Icon(Icons.check_circle,
                                  color: Colors.white, 
                                  size: dashboardCardHeight * 0.20,
                              ),
                            ),
                            SizedBox(
                              height: genderHeight * 0.20,
                              width: genderWidth * 0.20,
                              child: FittedBox(
                                child: Image.asset('lib/assets/icon/woman.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container heightBody(context) {
    return Container(
      height: heightBodyHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: heightBodyHeight * 0.30,
            child: FittedBox(
              child: Text(
                "Height".toUpperCase(),
                style: const TextStyle(color: textColor),
              ),
            ),
          ),
          Container(
            height: heightBodyHeight * 0.60,
            padding: EdgeInsets.only(top: heightBodyHeight * 0.10),
            child: SfSlider(
              min: 0.0,
              max: 200.0,
              value: currentHeightBody,
              interval: 30,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              onChanged: (dynamic value){
                setState(() {
                  currentHeightBody = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container weightBody() {
    return Container(
      height: weightBodyHeight,
      margin: EdgeInsets.only(bottom: weightBodyHeight * 0.75),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: weightBodyHeight * 0.30,
            child: FittedBox(
              child: Text(
                "Weight".toUpperCase(),
                style: const TextStyle(color: textColor),
              ),
            ),
          ),
          Container(
            height: weightBodyHeight * 0.60,
            padding: EdgeInsets.only(top: weightBodyHeight * 0.10),
            child: SfSlider(
              min: 0.0,
              max: 200.0,
              value: currentWeightBody,
              interval: 30,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              onChanged: (dynamic value){
                setState(() {
                  currentWeightBody = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buttonSection(context) {
    return Container(
      height: nextProfileFormHeight,
      width: nextProfileFormWidth,
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: primaryColor,
            tooltip: 'Next to dashboard',
            onPressed:(){
              BlocProvider.of<AuthBloc>(context).add(
                NextToDashBoardButton(
                  name: nameController.text,
                  dateOfBirth: currentDate,
                  gender: currentGender,
                  height: currentHeightBody!.roundToDouble(),
                  weight: currentWeightBody!.roundToDouble(),
                ),
              );
            },
            child: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      )
    );
  }
}
