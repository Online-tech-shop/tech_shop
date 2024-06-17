import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tech_shop/utils/app_constants.dart';
import 'package:tech_shop/utils/functions.dart';

import 'package:tech_shop/views/screens/login/sig_up.dart';
import 'package:tech_shop/views/screens/profile/widgets/profile_item.dart';
import 'package:tech_shop/views/screens/profile/widgets/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name = "";
  String? surname = ".";
  String? email = "";
  Future<void> getName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = await sharedPreferences.getString("name");
    surname = await sharedPreferences.getString("surname");
    email = await sharedPreferences.getString("email");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getName();
    return Scaffold(
      backgroundColor:
          CustomFunctions.isLight(context) ? Colors.white : Colors.black,
      body: Stack(
        children: [
          SizedBox(
            child: Image.asset(
              "assets/images/profile.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: 80,
                backgroundColor: CustomFunctions.isLight(context)
                    ? Colors.white
                    : Colors.black,
                clipBehavior: Clip.hardEdge,
                automaticallyImplyLeading: true,
                expandedHeight: 130.0,
                pinned: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        if (CustomFunctions.isLight(context)) {
                          AdaptiveTheme.of(context).setDark();
                        } else {
                          AdaptiveTheme.of(context).setLight();
                        }
                      },
                      child: Icon(
                        CustomFunctions.isLight(context)
                            ? Icons.dark_mode
                            : Icons.sunny,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: Row(
                    children: [
                      const Gap(15),
                      const CircleAvatar(
                        child: Center(
                          child: Icon(Icons.person),
                        ),
                      ),
                      const Gap(15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${name} ${surname?[0]}.",
                            // "aaa",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            email!,
                            // "aa",
                            style: const TextStyle(
                              letterSpacing: 1,
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  background: Image.asset(
                    "assets/images/profile.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: CustomFunctions.isLight(context)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              _buildProfileSection([
                ProfileItem(
                  ikon: const Icon(Icons.shopping_bag_outlined),
                  name: tr("buyurtmalarim"),
                ),
                ProfileItem(
                  ikon: const Icon(CupertinoIcons.smiley),
                  name: tr("sharhlarim"),
                ),
                ProfileItem(
                  ikon: const Icon(Icons.calendar_month_rounded),
                  name: tr("buyurtmalarim"),
                ),
              ]),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: CustomFunctions.isLight(context)
                      ? Colors.grey[200]
                      : Colors.white,
                ),
              ),
              _buildProfileSection([
                ProfileItem(
                  ikon: const Icon(CupertinoIcons.chat_bubble_2),
                  name: tr('chatlarim'),
                ),
                ProfileItem(
                  ikon: const Icon(Icons.notifications_none),
                  name: tr("xabarnomalar"),
                ),
                ProfileItem(
                  ikon: const Icon(Icons.percent),
                  name: tr("promokodlarim"),
                ),
                ProfileItem(
                  ikon: const Icon(Icons.settings_rounded),
                  name: tr("sozlamalar"),
                ),
              ]),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: CustomFunctions.isLight(context)
                      ? Colors.grey[200]
                      : Colors.white,
                ),
              ),
              _buildProfileSection([
                _buildLanguageSetting(),
              ]),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: CustomFunctions.isLight(context)
                      ? Colors.grey[200]
                      : Colors.white,
                ),
              ),
              _buildProfileSection([
                ProfileItem(
                  ikon: const Icon(Icons.location_on_outlined),
                  name: tr("shahar"),
                ),
                ProfileItem(
                  ikon: const Icon(Icons.map_outlined),
                  name: tr("xaritadagi_topshirish_punktlari"),
                ),
              ]),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: CustomFunctions.isLight(context)
                      ? Colors.grey[200]
                      : Colors.white,
                ),
              ),
              _buildProfileSection([
                ProfileItem(
                  ikon: const Icon(Icons.help_outline_rounded),
                  name: tr("malumot"),
                ),
                ProfileItem(
                  ikon: const Icon(CupertinoIcons.mail),
                  name: tr("xaritadagi_topshirish_punktlari"),
                ),
              ]),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: Colors.grey[200],
                ),
              ),
              _buildLogoutButton(),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: CustomFunctions.isLight(context)
                      ? Colors.grey[200]
                      : Colors.white,
                ),
              ),
              const SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Ilova versiyasi: 1.36.3 (12884)",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 50),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(List<Widget> children) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          children
              .map((child) => Container(
                    color: Colors.white,
                    child: child,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildLanguageSetting() {

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => SettingsScreen()));
      },
      child: Container(
        height: 50,
        color: Colors.white,
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/uzbekistan.png'),
                radius: 20,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ilova tili",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black26,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    return GestureDetector(
      onTap: () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (mounted) {
          if (context.locale.languageCode == 'uz') {
            context.setLocale(const Locale('ru'));
            AppConstants.appLanguageIndex = 1;
          } else {
            context.setLocale(const Locale('uz'));
            AppConstants.appLanguageIndex = 0;
          }
          sharedPreferences.setInt('lang-ind', AppConstants.appLanguageIndex);
        }
      },
      child: Container(
          height: 50,
          color: CustomFunctions.isLight(context) ? Colors.white : Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr("ilova_tili"),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: CustomFunctions.isLight(context)
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
            ),
          )),

    );
  }

  Widget _buildLogoutButton() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => const SigUp()));
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xff7000FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(
              child: Text(
                ("Chiqish"),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
