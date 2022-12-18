import 'package:app/constant.dart';
import 'package:app/screen/components/custom_app_bar.dart';
import 'package:app/screen/home/home_sreen.dart';
import 'package:flutter/material.dart';

class Preference extends StatefulWidget {
  const Preference({Key? key}) : super(key: key);

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  List<String> selection = ['Environement', 'Sante', 'Technologie'];

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        const CustomAppBar(),
        const SizedBox(height: 30,),
        Text("Selectioner un thème : ", style: Theme.of(context).textTheme.headline6,),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(globalSpacing),
            height: Size.height * 0.60,
            child: ListView.builder(
              itemCount: selection.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(globalSpacing),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(primaryColor),
                      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.all(globalPadding)),
                    ),
                    onPressed: () =>
                        navigateToHome(context, selection[index].toLowerCase()),
                    child: Text(
                      selection[index],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ]),
    );
  }

  navigateToHome(context, data) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomeScreen(theme: data)));
  }
}
