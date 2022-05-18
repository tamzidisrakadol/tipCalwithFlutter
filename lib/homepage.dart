import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tip_calculator/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _tipPercentage = 0;
  int _personCounter= 1;
  double _billAmount = 0;
  Color _purple = HexColor("#6908d6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.grey.shade200,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20),
          children: [
            Container(
              margin: EdgeInsets.all(20),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Per Person",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: _purple
                    ),),
                    SizedBox(height: 10,),
                    Text("\$ ${calculateTotalPerson(_billAmount, _personCounter, _tipPercentage)}",style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),)
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:TextInputType.numberWithOptions(decimal:true ),
                    style: TextStyle(color: _purple),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                    onChanged: (String value){
                      try{
                        _billAmount = double.parse(value);
                      }catch(exception){
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row
                    (mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split",style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState((){
                                if(_personCounter>1){
                                  _personCounter--;
                                }else{
                                  //do nothing
                                }
                              });
                            },
                            child:
                            Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: _purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text("-",style: TextStyle(color: Colors.purple,
                                    fontWeight: FontWeight.bold,fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personCounter",style: TextStyle(
                            color: _purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),),
                          InkWell(
                            onTap: (){
                              setState((){
                              _personCounter++;
                              });
                            },
                            child:
                            Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: _purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text("+",style: TextStyle(color: Colors.purple,
                                    fontWeight: FontWeight.bold,fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip",style: TextStyle(color: Colors.grey.shade700),),
                      Padding(
                          padding: EdgeInsets.all(12),
                        child:Text("\$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",style: TextStyle(color: _purple,fontWeight: FontWeight.bold,fontSize: 17),),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("$_tipPercentage",style: TextStyle(
                        color: Colors.purple,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _purple,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(), onChanged: (double value){
                        setState((){
                          _tipPercentage = value.round();
                        });
                      })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerson(double billAmount, int splitBy,int tipPercentage){
    var totalPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount)/splitBy;
    return totalPerson.toStringAsFixed(2);

  }


  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
   double  totalTip = 0.0;
   if(billAmount < 0 || billAmount.toString().isEmpty||billAmount == null){

   }else{
     totalTip = (billAmount * tipPercentage)/100;
   }
   return totalTip;
  }
}


