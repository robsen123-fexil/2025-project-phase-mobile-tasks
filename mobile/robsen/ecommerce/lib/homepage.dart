import 'package:ecommerce/widgets/product.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: Padding(
    padding: EdgeInsets.only(top: 10, left: 16),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 202, 201, 201),
          image: DecorationImage(
            image: AssetImage('assets/profile.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  ),
  title: Padding(
    padding: EdgeInsets.only(top: 20, bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "July 19, 2023",
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        SizedBox(height: 3),
        Row(
          children: [
            Text("Hello,", style: TextStyle(fontSize: 16)),
            SizedBox(width: 5),
            Text(
              'Robsen',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    ),
  ),
  actions: [
    Padding(
      padding: EdgeInsets.only(top: 10,),
      child: Container(
        height: 40
        , width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: IconButton(
          onPressed: () {
            // action here
          },
          icon: Icon(
            Icons.notifications_on_outlined,
            size: 16,
            color: Color.fromARGB(255, 36, 100, 238),
          ),
        ),
      ),
    ),
  ],
)
,
SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Available Products" , style: TextStyle(fontWeight: FontWeight.w900  , fontSize: 24),) , 
                   Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
        
                      border: Border.all(
                        color: const Color.fromARGB(255, 206, 204, 204),
                        width: 1
                      )
                      
                    ),
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.search , color: const Color.fromARGB(255, 204, 201, 201),))
                   )
                ],
              ),
              SizedBox(height: 30,) , 
              productcard(
                Image(image: AssetImage('assets/show.webp') , 
                
                ),
                'Derby Shoes' , 
                'mens shoes'  ,
                120, 
                4
        
              ),
              SizedBox(height: 10,),productcard(
                Image(image: AssetImage('assets/show.webp') , 
                
                ),
                'Derby Cotton' , 
                'mens shoes'  ,
                100 , 
                4
        
              ),
              SizedBox(height: 5,),productcard(
                Image(image: AssetImage('assets/show.webp') , 
                
                ),
                'derby' , 
                'mens shoes'  ,
                100 , 
                4
        
              ),
              SizedBox(height: 5,),productcard(
                Image(image: AssetImage('assets/show.webp') , 
                
                ),
                'derby' , 
                'mens show'  ,
                100 , 
                4
        
              ),
              SizedBox(height: 5,)
              
            ],
          ),
          
        ),
        

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
      backgroundColor: const Color.fromARGB(255, 0, 140, 255),
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Icon(Icons.add , color: Colors.white,),
      ),
    );
  }

 
}