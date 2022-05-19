
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit/bloc/navbar/navbar_bloc.dart';
import 'package:fit/view/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

homePage() {
  return BlocBuilder<NavbarBloc, NavbarState>(
    builder: (context, state) {

      print("homeState: ${state}");

      return Container(
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  dashboard(),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Column dashboard() {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Container(
              height: dashboardCardHeight,
              width: dashboardCardWidth,
              child: Card(
                color: Colors.blue[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.admin_panel_settings_rounded,
                          color: primaryColor, size: 40),
                    ),
                    SizedBox(
                      height: dashboardCardHeight * 0.20,
                      child: FittedBox(
                        child: Text(
                          "test 1",
                          style: const TextStyle(color: textColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: dashboardCardHeight * 0.15,
                      child: FittedBox(
                        child: Text(
                          "test 2",
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}