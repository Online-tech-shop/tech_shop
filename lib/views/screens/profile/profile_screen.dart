import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/views/screens/profile/widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: screenH * 0.16,
            backgroundColor: Colors.purple,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: EdgeInsets.only(top: 0.13 * screenW),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "abdujalil a.",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "+998 90 134-19-13",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              centerTitle: false,
              background: Container(
                alignment: Alignment.center,
                child: Container(
                    child: const Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: 130,
                      left: 140,
                      child: Text(
                        "Shaxsiy kabinet",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 13),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ProfileItem(
                    ikon: const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                    name: "Buyurtmalarim",
                  ),
                  ProfileItem(
                    ikon: const Icon(
                      CupertinoIcons.smiley,
                    ),
                    name: "Sharhlarim",
                  ),
                  ProfileItem(
                    ikon: const Icon(
                      Icons.calendar_month_rounded,
                    ),
                    name: "Buyurtmalarim",
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 13),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ProfileItem(
                    ikon: const Icon(
                      CupertinoIcons.chat_bubble_2,
                    ),
                    name: "Chatlarim",
                  ),
                  ProfileItem(
                    ikon: const Icon(
                      Icons.notifications_none,
                    ),
                    name: "Xabarnomalar",
                  ),
                  ProfileItem(
                    ikon: const Icon(
                      Icons.percent,
                    ),
                    name: "Promokodlarim",
                  ),
                  ProfileItem(
                    ikon: const Icon(
                      Icons.settings_rounded,
                    ),
                    name: "Sozlamalar",
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 13),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 70,
                          height: 70,
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/uzbekistan.png'),
                                    fit: BoxFit.cover)),
                            width: 40,
                            height: 40,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: double.infinity,
                          decoration: const BoxDecoration(),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ilova tili",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 13),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ProfileItem(
                    ikon: const Icon(
                      Icons.location_on_outlined,
                    ),
                    name: "Shahar",
                  ),
                  ProfileItem(
                    ikon: const Icon(
                      Icons.map_outlined,
                    ),
                    name: "Xaritadagi topshirish punktlari",
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 13),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ProfileItem(
                    ikon: const Icon(
                      Icons.help_outline_rounded,
                    ),
                    name: "Ma'lumot",
                  ),
                  ProfileItem(
                    ikon: const Icon(
                      CupertinoIcons.mail,
                    ),
                    name: "Xaritadagi topshirish punktlari",
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    child: InkWell(
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff7000FF),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text(
                            "Chiqish",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 22),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Text(
                    "Ilova versiyasi: 1.36.3 (12884)",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 50),
          ),
        ],
      ),
    );
  }
}