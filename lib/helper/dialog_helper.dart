import 'package:flutter/material.dart';
class ItemDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final String title;
  final VoidCallback onPressed;

  const ItemDialog({
    required this.nameController,
    required this.quantityController,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(hintText: 'Quantity'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: onPressed,
              child: Text(title),
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(
                  BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
