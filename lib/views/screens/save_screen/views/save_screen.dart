import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tech_shop/viewmodels/sql_view_model.dart';
import 'package:tech_shop/views/screens/home_screen/views/main_screen.dart';
import 'package:tech_shop/views/screens/save_screen/widgets/save_item.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  void initState() {
    super.initState();
    _refreshTasks();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshTasks());
    Provider.of<SaveViewModel>(context, listen: false).fetchSaves();
  }

  Future<void> _refreshTasks() async {
    try {
      await Provider.of<SaveViewModel>(context, listen: false).fetchSaves();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching tasks: $e')),
        );
      }
    }
  }

  void _changeQuantity(int id, bool increment) {
    final viewModel = Provider.of<SaveViewModel>(context, listen: false);
    if (increment) {
      viewModel.incrementQuantity(id);
      viewModel.incrementPrice(
        id,
      );
    } else {
      viewModel.decrementQuantity(id);
      viewModel.decrementPrice(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Consumer<SaveViewModel>(
          builder: (context, viewModel, child) {
            return Text(
              viewModel.saves.isEmpty
                  ? "Savat"
                  : "${viewModel.saves.length} ta mahsulot savatda",
            );
          },
        ),
      ),
      body: Consumer<SaveViewModel>(
        builder: (context, viewModel, child) {
          final saves = viewModel.saves;

          if (saves.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Gap(15),
                  Image.asset(
                    "assets/images/not.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const Gap(10),
                  const Text(
                    "Savatda hozircha mahsulot\nyo'q",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const Gap(5),
                  const Text(
                    "Bosh sahifadagi to'plamlardan boshlang yoki kerakli\nmahsulotni qidiruv orqali toping",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  const Gap(15),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Container(
                      width: 130,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple[500],
                      ),
                      child: const Center(
                        child: Text(
                          "Bosh sahifaga",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshTasks,
            child: ListView.builder(
              itemCount: saves.length,
              itemBuilder: (BuildContext context, int index) {
                final save = saves[index];
                return SaveItem(
                  save: save,
                  onDismissed: () {
                    viewModel.deleteSave(save.id as int);
                  },
                  onChangeQuantity: _changeQuantity,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
