import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/model/item.dart';

import '../helper/dialog_helper.dart';

class FirebaseController extends GetxController {
  
    var nameController = TextEditingController();
    var quantityController = TextEditingController();
  final colectionName = 'basket_items';

  RxList<Item> basketItems = RxList<Item>();

  @override
  void onInit() {
    fetchRecords();
    FirebaseFirestore.instance
        .collection('basket_items')
        .snapshots()
        .listen((records) {
      mapRecords(records);
    });
    super.onInit();
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection(colectionName).get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map(
          (item) => Item(
            id: item.id,
            name: item['name'],
            quantity: item['quantity'],
          ),
        )
        .toList();
    basketItems.assignAll(_list);
  }

  addItem(String name, String quantity) async {
    var item = Item(id: 'id', name: name, quantity: quantity);
    await FirebaseFirestore.instance.collection(colectionName).add(item.toMap());

  }

  updateItem(String id, String newName, String newQuantity) async {
    await FirebaseFirestore.instance.collection(colectionName).doc(id).update({
      'name': newName,
      'quantity': newQuantity,
    });
  }

  deleteItem(String id) async {
    await FirebaseFirestore.instance.collection(colectionName).doc(id).delete();
  }

 void showUpdateDialog(Item item, BuildContext context) {
    var nameController = TextEditingController(text: item.name);
    var quantityController = TextEditingController(text: item.quantity);
    showDialog(
      context: context,
      builder: (context) {
        return ItemDialog(
          nameController: nameController,
          quantityController: quantityController,
          title: 'Edit Item',
          onPressed: () {
            var newName = nameController.text.trim();
            var newQuantity = quantityController.text.trim();
            updateItem(item.id, newName, newQuantity);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  // showUpdateDialog(Item item,c) {
  //   var nameController = TextEditingController(text: item.name);
  //   var quantityController = TextEditingController(text: item.quantity);

  //   showDialog(
  //     context: c,
  //     builder: (context) {
  //       return Dialog(
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text('Edit Item'),
  //               TextField(
  //                 controller: nameController,
  //                 decoration: InputDecoration(hintText: 'Name'),
  //               ),
  //               TextField(
  //                 controller: quantityController,
  //                 decoration: InputDecoration(hintText: 'Quantity'),
  //               ),
  //               const SizedBox(height: 20),
  //               TextButton(
  //                 onPressed: () {
  //                   var newName = nameController.text.trim();
  //                   var newQuantity = quantityController.text.trim();
  //                   updateItem(item.id, newName, newQuantity);
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('Update'),
  //                 style: const ButtonStyle(
  //                   shape: MaterialStatePropertyAll(
  //                     BeveledRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(10)),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  // showItemDialog() {
  //   showDialog(
  //     context: Get.context!,
  //     builder: (context) {
  //       return Dialog(
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text('Items Details'),
  //               TextField(
  //                 controller: nameController,
  //                 decoration: InputDecoration(hintText: 'Name'),
  //               ),
  //               TextField(
  //                 controller: quantityController,
  //                 decoration: InputDecoration(hintText: 'Quantity'),
  //               ),
  //               const SizedBox(height: 20),
  //               TextButton(
  //                 onPressed: () {
  //                   var name = nameController.text.trim();
  //                   var quantity = quantityController.text.trim();
  //                   addItem(name, quantity);
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text('Add'),
  //                 style: const ButtonStyle(
  //                   shape: MaterialStatePropertyAll(
  //                     BeveledRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(10)),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
void showItemDialog(BuildContext context) {
    var nameController = TextEditingController();
    var quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return ItemDialog(
          nameController: nameController,
          quantityController: quantityController,
          title: 'Add Item',
          onPressed: () {
            var name = nameController.text.trim();
            var quantity = quantityController.text.trim();
            addItem(name, quantity);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
