import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_shop/models/product_item.dart';
import 'package:tech_shop/viewmodels/sql_view_model.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshTasks());
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
      viewModel.incrementPrice(id,);
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
            return Center(child: Image.asset("assets/images/not.png"));
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
