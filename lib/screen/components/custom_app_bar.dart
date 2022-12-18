import 'package:app/constant.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: globalPadding + 10, horizontal: globalSpacing - 5),
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(globalPadding + 10),
              bottomRight: Radius.circular(globalPadding + 10))),
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Image.asset('assets/images/go_share.png'),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.image_search,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }

}
