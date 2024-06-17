import 'package:flutter/material.dart';
import 'package:tech_shop/models/filtr_model.dart';
import 'package:tech_shop/utils/functions.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          CustomFunctions.isLight(context) ? Colors.white : Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color:
                CustomFunctions.isLight(context) ? Colors.black : Colors.white,
          ),
        ),
        backgroundColor:
            CustomFunctions.isLight(context) ? Colors.white : Colors.black,
        title: Text(
          CustomFunctions.isUzbek(context) ? 'Filtr' : 'Фильтр',
          style: TextStyle(
            color:
                CustomFunctions.isLight(context) ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filtrList.length,
              itemBuilder: (context, index) {
                final data = filtrList[index];
                return ListTile(
                  title: Text(
                    data.title,
                    style: TextStyle(
                      color: CustomFunctions.isLight(context)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      for (var item in filtrList) {
                        item.isSelected = false;
                      }
                      data.isSelected = true;
                    });
                  },
                  trailing: data.isSelected
                      ? const Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : null,
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Text(
                          CustomFunctions.isUzbek(context) ? "dan" : 'от',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Text(
                          CustomFunctions.isUzbek(context) ? "oldin" : 'до',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
