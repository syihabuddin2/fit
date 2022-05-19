
import 'package:fit/bloc/auth/auth_bloc.dart';
import 'package:fit/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String? currentname = "";
String? currentgender = "";
String? currentdateOfbirth = "";
double? currentheight = 0;
double? currentweight = 0;

profilePage() {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {

      print("profileState: ${state}");

      if (state is ProfileSuccessState) {
        currentname = state.name;
        currentgender = state.gender;
        currentdateOfbirth = state.dateOfBirth;
        currentheight = state.height;
        currentweight = state.weight;
      }

      return Container(
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  profileSetting(context),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Column profileSetting(context) {
  return Column(
    children: [
      SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("ACCOUNT"),
              const SizedBox(height: 10.0),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Text(
                        "Name"
                      ),
                      title: Text(
                        currentname.toString()
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Text(
                        "Gender"
                      ),
                      title: Text(
                        currentgender.toString()
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Text(
                        "Birthday"
                      ),
                      title: Text(
                        currentdateOfbirth.toString()
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Text(
                        "Height"
                      ),
                      title: Text(
                        currentheight.toString()
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Text(
                        "Weight"
                      ),
                      title: Text(
                        currentweight.toString()
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Divider(),
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0,),
                child: ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Logout"),
                  onTap: (){
                    BlocProvider.of<AuthBloc>(context).add(
                      LogoutPressButton(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
    ],
  );
}