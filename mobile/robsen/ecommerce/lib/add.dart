// ignore_for_file: deprecated_member_use

import 'package:ecommerce/widgets/text_field.dart';
import 'package:ecommerce/widgets/textbutton.dart';
import 'package:flutter/material.dart';

class Addpage extends StatelessWidget {
  const Addpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
        title: Text('Add Product' , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold), ),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 222, 220, 220)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.image_outlined , size: 40, weight: 10,)) , 
                    SizedBox(height: 10,) , 
                    Text('upload image') 
                  ],
                ),
              ) , 
              SizedBox(height: 10,),
              Text('name' , style: TextStyle(fontWeight: FontWeight.w600),) , 
              SizedBox(height: 10,) , 
              Text_field(false , false) , 
               SizedBox(height: 10),
              Text('categories', style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Text_field(false , false),  SizedBox(height: 10),
              Text('price', style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Text_field(false ,false),  SizedBox(height: 10),
              Text('Description', style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Text_field(false , true), 
              SizedBox(height: 20,) , 
              Column(children: [
                textbutton('ADD    ' ,  Color.fromARGB(255, 22, 83, 190) , Colors.white , Color.fromARGB(255, 2, 101, 181) , ) ,
                SizedBox(height: 10,),
                textbutton('DELETE', Colors.white , Colors.red, Colors.red)

              ],)
            ],
          ),
        ),
      ),
    );
  }


}