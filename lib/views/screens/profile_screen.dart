import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 130,
            backgroundColor: Colors.amber,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Abdujalil",
              ),
              centerTitle: false,
              background: Container(
                alignment: Alignment.center,
                child: const Text("Shaxsiy kabinet"),
              ),
            ),
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
                          width: 50,
                          height: 50,
                          child: const Center(
                            child: Icon(Icons.shopping_bag_outlined),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: double.infinity,
                          width: 370,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.black26))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("data"),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black45,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    decoration: BoxDecoration(),
                    child: const ListTile(
                      leading: Icon(Icons.home),
                      title: Text("asds"),
                    ),
                  ),
                  ListTile(
                    title: Text("asds"),
                  ),
                  ListTile(
                    title: Text("asds"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
