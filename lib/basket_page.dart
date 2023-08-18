
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutterfire/model/item.dart';
// import 'helper/dialog_helper.dart';
// const colectionName = 'basket_items';
// class BasketPage extends StatefulWidget {
//   const BasketPage({super.key});
//   @override
//   State<BasketPage> createState() => _nameState();
// }
// class _nameState extends State<BasketPage> {
//   List<Item> basketItems = [];
//   @override
//   void initState() {
//    // DialogHelper.showLoading('getting data');
//     fetchRecords();
//     FirebaseFirestore.instance.
//     collection('basket_items').
//     snapshots().listen((records) { 
//     mapRecords(records);
//     });
//     super.initState();
//   }
//   fetchRecords() async{
//   var records = await FirebaseFirestore.instance.collection(colectionName).get();
//   mapRecords(records);
//   }
//   mapRecords(QuerySnapshot<Map<String, dynamic>> records)
//   {
//    var _list =records.docs.map((item) => Item(id: item.id,
//     name: item['name'] ,
//      quantity: item['quantity']
//      )
//      ).toList();
//      setState(() {
//        basketItems = _list;
//      });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(actions: [IconButton(onPressed: () {
//         showItemDialog();
//       }, icon: const Icon(Icons.add))]),
//       body: ListView.builder(
//         itemCount: basketItems.length,
//         itemBuilder: (context, index) {
//           return Slidable(
//             endActionPane: ActionPane(
//               motion: ScrollMotion(),
//              children: [
//               SlidableAction(
//               onPressed: (c){
//                 deleteItem(basketItems[index].id);
//               }, 
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//               icon: Icons.delete,
//               label: 'delete',
//               spacing: 8,
//               ),
//                SlidableAction(
//             onPressed: (c) {
//               showUpdateDialog(basketItems[index]);
//             },
//             backgroundColor: Colors.blue,
//             foregroundColor: Colors.white,
//             icon: Icons.edit,
//             label: 'Edit',
//             spacing: 8,
//           ),
//              ]),
//             child: Card(
//               child: ListTile(
//                 title:  Text(basketItems[index].name),
//                 subtitle: Text(basketItems[index].quantity ?? ''),
                      
//               ),
//             ),
//           );
//         },


//       ),
//     );
//   }
//   showItemDialog(){
//     var nameController = TextEditingController();
//     var quantityController = TextEditingController();
//     showDialog(context: context, builder: (context){
//     return Dialog( 
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Items Details'),
//             TextField( 
//               controller: nameController,
//               decoration: InputDecoration(hintText: 'Name'),
//             ),
//             TextField(
//               controller: quantityController,
//                  decoration: InputDecoration(hintText: 'Quantity'),
//             ),
//             const SizedBox(height: 20,),
//             TextButton(onPressed: () {
//               var name = nameController.text.trim();
//               var quantity = quantityController.text.trim();
//               addItem(name, quantity);
              
//             }, child: Text('add'),
//              style: const ButtonStyle(shape: MaterialStatePropertyAll
//              (BeveledRectangleBorder(borderRadius:
//               BorderRadius.all(Radius.circular(10))))),)
//           ],
//         ),
//       ),
//     );
//     });
//   }
//   addItem(String name ,String quantity){
//     var item = Item(id: 'id', name: name , quantity: quantity );
//     FirebaseFirestore.instance.collection(colectionName).add(item.toMap());
  
//   }
//   deleteItem(String id){
//     FirebaseFirestore.instance.collection(colectionName).doc(id).delete();

//   }
//   updateItem(String id, String newName, String newQuantity) async {
//   await FirebaseFirestore.instance.collection(colectionName).doc(id).update({
//     'name': newName,
//     'quantity': newQuantity,
//   });
// }
// showUpdateDialog(Item item) {
//   var nameController = TextEditingController(text: item.name);
//   var quantityController = TextEditingController(text: item.quantity);

//   showDialog(
//     context: context,
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
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'controller/firebase_action_controler.dart';
class BasketPage extends StatelessWidget {
  final FirebaseController firebaseController = Get.put(FirebaseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              firebaseController.showItemDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: firebaseController.basketItems.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction( autoClose: true,
                  padding: EdgeInsets.all(10),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                    onPressed: (c) {
                      firebaseController.deleteItem(
                          firebaseController.basketItems[index].id);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                    spacing: 8,
                  ),
                  SlidableAction(
                   padding: EdgeInsets.all(10),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    onPressed: (c) {
                      firebaseController.showUpdateDialog(
                          firebaseController.basketItems[index],c);
                    },
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                    spacing: 8,
                  ),
                ],
              ),
              child: Card(
                child: ListTile(
                  title: Text(firebaseController.basketItems[index].name),
                  subtitle:
                      Text(firebaseController.basketItems[index].quantity ?? ''),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
