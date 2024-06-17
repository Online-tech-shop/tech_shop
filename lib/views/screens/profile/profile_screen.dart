import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/models/user_model.dart';

import 'package:tech_shop/utils/app_constants.dart';
import 'package:tech_shop/utils/functions.dart';

import 'package:tech_shop/views/screens/login/sig_up.dart';
import 'package:tech_shop/views/screens/profile/widgets/profile_item.dart';
import 'package:tech_shop/views/screens/profile/widgets/settings_screen.dart';

// aaa
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<User> getUser() async {
    return await AppConstants.getUser();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            CustomFunctions.isLight(context) ? Colors.white : Colors.black,
        body: FutureBuilder(
          future: getUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.hasError) {
              return Center(
                child: Text('error: snapshot ${snapshot.error}'),
              );
            } else {
              User user = snapshot.data;
              return Stack(
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
                                    user.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    user.email,
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
              );
            }
          },
        ));

  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 80,
      backgroundColor:
          CustomFunctions.isLight(context) ? Colors.white : Colors.black,
      clipBehavior: Clip.hardEdge,
      automaticallyImplyLeading: true,
      expandedHeight: 130.0,
      pinned: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () => _toggleTheme(context),
            child: Icon(
              CustomFunctions.isLight(context) ? Icons.dark_mode : Icons.sunny,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        title: _buildProfileTitle(),
        background: Image.asset(
          "assets/images/profile.jpg",
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  Row _buildProfileTitle() {
    return Row(
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
              "$name ${surname?[0]}.",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              email!,
              style: const TextStyle(
                letterSpacing: 1,
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileSections(BuildContext context) {
    final isLight = CustomFunctions.isLight(context);
    final backgroundColor = isLight ? Colors.white : Colors.black;

    return SliverList(
      delegate: SliverChildListDelegate([
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
        ], backgroundColor),
        _buildDivider(isLight),
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
        ], backgroundColor),
        _buildDivider(isLight),
        _buildProfileSection([
          _buildLanguageSetting(),
        ], backgroundColor),
        _buildDivider(isLight),
        _buildProfileSection([
          ProfileItem(
            ikon: const Icon(Icons.location_on_outlined),
            name: tr("shahar"),
          ),
          ProfileItem(
            ikon: const Icon(Icons.map_outlined),
            name: tr("xaritadagi_topshirish_punktlari"),
          ),
        ], backgroundColor),
        _buildDivider(isLight),
        _buildProfileSection([
          ProfileItem(
            ikon: const Icon(Icons.help_outline_rounded),
            name: tr("malumot"),
          ),
          ProfileItem(
            ikon: const Icon(CupertinoIcons.mail),
            name: tr("xaritadagi_topshirish_punktlari"),
          ),
        ], backgroundColor),
        _buildDivider(isLight),
      ]),
    );
  }

  Widget _buildProfileSection(List<Widget> children, Color backgroundColor) {
    return Column(
      children: children
          .map((child) => Container(
                color: backgroundColor,
                child: child,
              ))
          .toList(),
    );
  }

  Widget _buildDivider(bool isLight) {
    return Container(
      height: 13,
      color: isLight ? Colors.grey[200] : Colors.white,
    );
  }

  Widget _buildLanguageSetting() {
    return InkWell(
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black26,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () async{
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setBool('isLogged', false);
            if(mounted) {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (ctx) => const SigUp()));
            }

          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xff7000FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child:  Center(
              child: Text(
                CustomFunctions.isUzbek(context) ? "Chiqish" : 'Vixod',
                style: const TextStyle(

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
