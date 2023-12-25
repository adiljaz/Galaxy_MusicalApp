import 'package:flutter/material.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
     MediaQueryData mediaQuerry = MediaQuery.of(context);
    return  SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
    
              children: [
    
               
              
                Container(
                  
                  height: mediaQuerry.size.height*0.25  ,
              
                  child:     Center(child: Padding(
                    
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center ,
                        
                        children: [
                          Center(child: Text('Search  ',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold ),))
                        ],
                       ),
                       SizedBox(height: mediaQuerry.size.height*0.04,),
                        TextFormField( decoration: InputDecoration( filled: true,  fillColor: Colors.white ,  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),hintText: 'Search..',suffixIcon:Icon(Icons.search)), ), 
                      ],
                    ),
                  )) ,
                  decoration: BoxDecoration(color: Colors.black ,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))),
                ),
               
              ],
            ),
            
               
            
           
          ],
        ),
      ),
    );
  }
}