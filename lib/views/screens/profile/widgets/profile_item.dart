import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/utils/functions.dart';
import 'package:tech_shop/views/screens/profile/widgets/edit_profile_item.dart';

class ProfileItem extends StatefulWidget {
  final num;
  final Icon icon;
  final String name;
  final Function()? onSetState;
  const ProfileItem({
    super.key,
    required this.icon,
    required this.name,
    this.num,
    this.onSetState,
  });

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.num == 1) {
          var data = await showDialog(
              context: context, builder: (ctx) => EditProfileItem());
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("name", data["name"]);
          sharedPreferences.setString("surname", data["surname"]);
          print(data["surname"]);
        }
      },
      child: Container(
        height: 50,
        color: CustomFunctions.isLight(context) ? Colors.white : Colors.black,
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(

                  // color:  CustomFunctions.isLight(context) ? Colors.grey : Colors.white,
                  shape: BoxShape.circle),
              child: Center(
                child: widget.icon,
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: double.infinity,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: CustomFunctions.isLight(context)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: CustomFunctions.isLight(context)
                        ? Colors.black
                        : Colors.white,
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
