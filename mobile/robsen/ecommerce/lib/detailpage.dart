// ignore_for_file: deprecated_member_use

import 'package:ecommerce/widgets/button.dart' show Button;
import 'package:ecommerce/widgets/size.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Detailpage extends StatelessWidget {
  const Detailpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/show.webp'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 30,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        context.go('/');
                      },
                      icon: Icon(Icons.arrow_back_ios , color: const Color.fromARGB(255, 67, 16, 255),size: 15,),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8,) , 
          Padding(padding: EdgeInsets.all(20) , 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mens shoe '),
                  Text('⭐ 4.0')



              ],) , 
              SizedBox(height: 10,) , 
              Row(
              
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Derby Leather' , style: TextStyle(fontWeight: FontWeight.w900 , fontSize: 16),) , 
                  Text("120\$" , style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ) ,
              SizedBox(height: 10,) , 
              Text('Size:') , 
              SizedBox(height: 10,) , 
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  Sizes('39' , false) ,
                  Sizes('40' , false) ,
                  Sizes('41' , true), Sizes('42' , false) , Sizes('43' , false), Sizes('44' , false) ,
                
                
                ],),
              ) ,
              SizedBox(height: 10,) , 
              Text(
                  'Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et Robsen Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur Excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum',
                  style: TextStyle(fontSize: 14 , color: const Color.fromARGB(255, 121, 121, 121)),
                ) ,
                SizedBox(height: 20,) , 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button('Delete' , Colors.white  , Colors.red, Colors.red ),
                    Button('Update' , const Color.fromARGB(255, 0, 87, 159), Colors.white , Colors.blue)
  
                  
                  ],
                )


            ],
          ),
          
          )
        ],
      ),
    );
  }

 

  
}
