import 'package:fit/bloc/navbar/navbar_bloc.dart';
import 'package:fit/view/home/home.dart';
import 'package:fit/view/profile/profile.dart';
import 'package:fit/view/util/appbar.dart';
import 'package:fit/view/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  double? currentWeightBody = 0;

  @override
  Widget build(BuildContext context) {
    heightSize = MediaQuery.of(context).size.height;
    widthSize = MediaQuery.of(context).size.width;

    shortestSide = MediaQuery.of(context).size.shortestSide;
    isMobile = shortestSide < 600.0;
    orientation = MediaQuery.of(context).orientation;

    return BlocBuilder<NavbarBloc, NavbarState>(builder: (context, state) {
      int? currentIndex;
      String? title;
      var body;

      if (state is HomeNavBar) {
        currentIndex = state.itemIndex;
        title = state.title;
        body = homePage();
      }

      if (state is ProfileNavBar) {
        currentIndex = state.itemIndex;
        title = state.title;
        body = profilePage();
      }

      responsiveLayout(isMobile, orientation);

      return Scaffold(
        appBar: TopBar(
          titleBar: title!,
        ),
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex!,
          onTap: (index) {
            if (index == 0) {
              BlocProvider.of<NavbarBloc>(context).add(NavbarEvents.Home);
            } else if (index == 1) {
              BlocProvider.of<NavbarBloc>(context).add(NavbarEvents.Profile);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: "Profile",
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            addWeightDialog(context);
          },
          tooltip: 'Add Data',
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  addWeightDialog(context) {
    return showDialog(
      context: context, 
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20.0)),
            child: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterLogo(size: 150,),
                  Container(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text("Close"),
                      ),
                      SizedBox(width: 20.0),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text("Add"),
                      )
                    ],
                  )
                ],
              ),
            ),
        );
      }
    );
  }
}