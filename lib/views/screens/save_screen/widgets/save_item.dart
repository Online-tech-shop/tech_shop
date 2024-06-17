import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tech_shop/models/sql_model.dart';
import 'package:tech_shop/views/screens/save_screen/widgets/flush_bar.dart';
import 'package:tech_shop/views/screens/save_screen/widgets/quantity_changer.dart';

class SaveItem extends StatelessWidget {
  final Save save;
  final VoidCallback onDismissed;
  final void Function(int id, bool increment) onChangeQuantity;

  const SaveItem({
    required this.save,
    required this.onDismissed,
    required this.onChangeQuantity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("a");
      },
      child: Dismissible(
        key: Key(save.id.toString()),
        background: Container(
          color: Colors.grey.withOpacity(.3),
          padding: const EdgeInsets.only(right: 30),
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.delete_solid,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "O'chirish",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          FlushBars.undo(
            message: "Mahsulot o'chirildi",
            duration: const Duration(seconds: 2),
          ).show(context);
          onDismissed();
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 120,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  save.image,
                  fit: BoxFit.fill,
                ),
              ),
              const Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${save.price} so'm",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      save.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(20),
                    Text(
                      "Sotuvchi ${save.seller}",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const Gap(15),
                    Text(
                      "${save.price} so'm/dona",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                    const Gap(5),
                    QuantityChanger(
                      quantity: save.quantity,
                      onDecrement: () {
                        if (save.quantity == 1) {
                          onDismissed();
                        } else {
                          onChangeQuantity(save.id as int, false);
                        }
                      },
                      onIncrement: () => onChangeQuantity(save.id as int, true),
                      onDismissed: onDismissed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
