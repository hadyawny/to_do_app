import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/my_provider.dart';
import 'package:to_do_app/shared/styles/colors.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  bool darkMode = false;

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<MyProvider>(context);


    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Dark Mode",style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.secondary

            ),),
            Switch(
              activeColor: Colors.white,
              activeTrackColor: primary,
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: primary,
              value: darkMode,
              onChanged: (bool value){

                setState(() {
                  darkMode=!darkMode;
                  provider.changeTheme();
                });

              },
            ),
          ],)
        ],
      ),
    );
  }
}
