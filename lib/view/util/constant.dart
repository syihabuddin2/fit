import 'package:flutter/material.dart';

///Color Setting
const primaryColor = Color(0xFF81DEBB);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const cardColor = Colors.white;
const textColor = Colors.black;

///Responsive Layout
late double heightSize, widthSize;
late double shortestSide;
late double statusBarHeight;
late bool isMobile;
late Orientation orientation;
late double dashboardCardHeight, dashboardCardWidth;
late double genderHeight, genderWidth, titleHeight, titleWidth, nameHeight, nameWidth,
  dateOfBirthHeight, dateOfBirthWidth, heightBodyHeight, heightBodyWidth, 
  weightBodyHeight, weightBodyWidth, nextProfileFormHeight, nextProfileFormWidth;

double dashboardCardHeightMobilePotrait = 0.20; //Mobile
double dashboardCardWidthMobilePotrait = 1.0; //Mobile
double dashboardCardHeightMobileLandscape = 0.43; //Mobile
double dashboardCardWidthMobileLandscape = 1.0; //Mobile

responsiveLayout(isMobile, orientation) {
  if (isMobile) {
    /// Mobile
    if (orientation == Orientation.portrait) {
      /// Potrait
      titleHeight = heightSize * 0.20;
      titleWidth = widthSize * 1.0;

      nameHeight = heightSize * 0.20;
      nameWidth = widthSize * 1.0;

      dateOfBirthHeight = heightSize * 0.20;
      dateOfBirthWidth = widthSize * 1.0;
       
      //Gender
      genderHeight = heightSize * 0.30;
      genderWidth = widthSize * 1.0;

      heightBodyHeight = heightSize * 0.20;
      heightBodyWidth = widthSize * 1.0;

      weightBodyHeight = heightSize * 0.20;
      weightBodyWidth = widthSize * 1.0;

      nextProfileFormHeight = heightSize * 0.15;
      nextProfileFormWidth = widthSize * 1.0;

      //Dashboard
      dashboardCardHeight = heightSize * dashboardCardHeightMobilePotrait;
      dashboardCardWidth = widthSize * dashboardCardWidthMobilePotrait; 
    } else {
      /// Landscape
      titleHeight = heightSize * 0.20;
      titleWidth = widthSize * 1.0;

      nameHeight = heightSize * 0.20;
      nameWidth = widthSize * 1.0;

      dateOfBirthHeight = heightSize * 0.20;
      dateOfBirthWidth = widthSize * 1.0;
      
      //Gender
      genderHeight = heightSize * 0.30;
      genderWidth = widthSize * 1.0;

      heightBodyHeight = heightSize * 0.20;
      heightBodyWidth = widthSize * 1.0;

      weightBodyHeight = heightSize * 0.20;
      weightBodyWidth = widthSize * 1.0;

      nextProfileFormHeight = heightSize * 0.20;
      nextProfileFormWidth = widthSize * 1.0;

      //Dashboard
      dashboardCardHeight = heightSize * dashboardCardHeightMobileLandscape;
      dashboardCardWidth = widthSize * dashboardCardWidthMobileLandscape;
    }
  }
}