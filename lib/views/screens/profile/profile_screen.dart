import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tech_shop/views/screens/profile/widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
                backgroundColor: const Color.fromARGB(189, 0, 0, 0),
                clipBehavior: Clip.hardEdge,
                automaticallyImplyLeading: true,
                expandedHeight: 130.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: const Row(
                    children: [
                      Gap(15),
                      CircleAvatar(
                        child: Center(
                          child: Icon(Icons.person),
                        ),
                      ),
                      Gap(15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Mardon H.",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "+998 97 421 0412",
                            style: TextStyle(
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
                  color: Colors.grey[200],
                ),
              ),
              _buildProfileSection([
                const ProfileItem(
                  ikon: Icon(Icons.shopping_bag_outlined),
                  name: "Buyurtmalarim",
                ),
                const ProfileItem(
                  ikon: Icon(CupertinoIcons.smiley),
                  name: "Sharhlarim",
                ),
                const ProfileItem(
                  ikon: Icon(Icons.calendar_month_rounded),
                  name: "Buyurtmalarim",
                ),
              ]),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: Colors.grey[200],
                ),
              ),
              _buildProfileSection([
                const ProfileItem(
                  ikon: Icon(CupertinoIcons.chat_bubble_2),
                  name: "Chatlarim",
                ),
                const ProfileItem(
                  ikon: Icon(Icons.notifications_none),
                  name: "Xabarnomalar",
                ),
                const ProfileItem(
                  ikon: Icon(Icons.percent),
                  name: "Promokodlarim",
                ),
                const ProfileItem(
                  ikon: Icon(Icons.settings_rounded),
                  name: "Sozlamalar",
                ),
              ]),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: Colors.grey[200],
                ),
              ),
              _buildProfileSection([
                _buildLanguageSetting(),
              ]),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: Colors.grey[200],
                ),
              ),
              _buildProfileSection([
                const ProfileItem(
                  ikon: Icon(Icons.location_on_outlined),
                  name: "Shahar",
                ),
                const ProfileItem(
                  ikon: Icon(Icons.map_outlined),
                  name: "Xaritadagi topshirish punktlari",
                ),
              ]),
              SliverToBoxAdapter(
                child: Container(
                  height: 13,
                  color: Colors.grey[200],
                ),
              ),
              _buildProfileSection([
                const ProfileItem(
                  ikon: Icon(Icons.help_outline_rounded),
                  name: "Ma'lumot",
                ),
                const ProfileItem(
                  ikon: Icon(CupertinoIcons.mail),
                  name: "Xaritadagi topshirish punktlari",
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
                  color: Colors.grey[200],
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
    return Container(
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
    );
  }

  Widget _buildLogoutButton() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {
            // Handle logout
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
