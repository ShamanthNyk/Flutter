import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';
import 'coin_data.dart';
import 'coin_data.dart';
import 'coin_data.dart';

//const apiKey='C0AF0376-65B9-47D9-AA94-65CA880F6225';
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String bttype;
  String selectedcurrency='AUD';
  Map<String, String> placeholder_value = {};
  bool isWaiting = false;


  void getData() async{
    isWaiting=true;
    try {
      CoinData cdata=CoinData();
       var coindata = await cdata.getCoinData(currtype: selectedcurrency);
       isWaiting=false;
      setState(() {
        placeholder_value = coindata;
      });
    }
    catch(e){
      print(e);
    }
  }



  DropdownButton<String> Androiddropdown(){
  List<DropdownMenuItem<String>> dropdownitems=[];
  for (String x in currenciesList){
  var newitem= DropdownMenuItem(
  child:Text(x),
  value:x,
  );
  dropdownitems.add(newitem);
  }
   return  DropdownButton<String>(
    value:selectedcurrency,
    items:dropdownitems,
    onChanged:(value){
    setState(() {
    selectedcurrency=value;
    getData();
    });
    },
    );
  }

  CupertinoPicker iosPicker(){
    List<Text> newlist=[];
    for(String x in currenciesList){
      newlist.add(Text(x));
    }


    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        print(selectedIndex);
        setState(() {
          selectedcurrency=currenciesList[selectedIndex];
          print(selectedcurrency);
          getData();
        });

      },
      children:newlist,
    );
  }

  Widget getPicker(){
    if(Platform.isIOS){
      return iosPicker();
    }
    else if(Platform.isAndroid){
      return Androiddropdown();
    }
  }



  void initState(){
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          newcard(placeholder_value: isWaiting ? '?' : placeholder_value['BTC'],
            selectedcurrency: selectedcurrency,bttype: 'BTC',),
          newcard(placeholder_value: isWaiting ? '?' : placeholder_value['ETH'],
               selectedcurrency: selectedcurrency,bttype: 'ETH',),
          newcard(placeholder_value: isWaiting ? '?' : placeholder_value['LTC'],
               selectedcurrency: selectedcurrency,bttype: 'LTC',),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:iosPicker(),
          ),
        ],
      ),
    );
  }
}

class newcard extends StatelessWidget {

  final String placeholder_value;
  final String selectedcurrency;
  final String bttype;
  newcard({this.placeholder_value,this.selectedcurrency,this.bttype});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $bttype = $placeholder_value $selectedcurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


