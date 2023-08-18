import 'package:flutter/material.dart';
import 'package:flutterfire/basket_page.dart';
import 'package:flutterfire/controller/firebase_action_controler.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = FirebaseController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase'), centerTitle: true,),
   body: Column( mainAxisAlignment: MainAxisAlignment.center,

    children: [
      Center(
        child: TextButton(onPressed: () {
         // DialogHelper.showLoading( 'Getting data');
          Navigator.push(context, MaterialPageRoute(builder: (context)=> BasketPage()));
      
        }, child: Text('Go to Basket')),
      )
    ],
   ), );
  }

}