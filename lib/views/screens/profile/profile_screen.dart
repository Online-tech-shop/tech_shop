import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
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
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name") ?? "";
      surname = sharedPreferences.getString("surname") ?? ".";
      email = sharedPreferences.getString("email") ?? "";
      profileImagePath = sharedPreferences.getString("profileImagePath");
    });
  }

  Future<void> _updateProfilePicture(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('profileImagePath', pickedFile.path);

      setState(() {
        profileImagePath = pickedFile.path;
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _updateProfilePicture(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _updateProfilePicture(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleTheme(BuildContext context) {
    if (CustomFunctions.isLight(context)) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomFunctions.isLight(context) ? Colors.white : Colors.black,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/profile.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          CustomScrollView(
            slivers: [
              _buildSliverAppBar(context),
              _buildProfileSections(context),
              _buildLogoutButton(),
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

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 80,
      backgroundColor: CustomFunctions.isLight(context) ? Colors.white : Colors.black,
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
        GestureDetector(
          onTap: _showImagePickerOptions,
          child: CircleAvatar(
            backgroundImage: profileImagePath != null ? FileImage(File(profileImagePath!)) : null,
            child: profileImagePath == null ? const Icon(Icons.person) : null,
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
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
          onTap: () {
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (ctx) => const SigUp()));
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xff7000FF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(
              child: Text(
                "Chiqish",
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
