import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pecel_lele_adv/model/cuaca_model.dart';
class HomeView extends StatefulWidget{
  @override
  _HomeViewState createState()=> _HomeViewState();
}

class _HomeViewState extends State<HomeView>{
  String dropdownValue = '-';
  List<CuacaModel> cuacaModel =List();
  void getCheckItem()async{
    var url = 'http://192.168.0.101/bmkg/?menu=cuaca&wilayah=$dropdownValue';
    cuacaModel.clear();
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        cuacaModel.addAll(cuacaModelFromJson(response.body));
      });

      print('Number of books about http: $jsonResponse.');
      print('Number of books about http: ${cuacaModel.length}');

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuaca BMKG"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("List BMKG"),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                  getCheckItem();
                });
              },
              items: <String>['-','jabar', 'jateng', 'jatim', 'sumut']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Container(
              child: cuacaModel.length != null ?
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cuacaModel.length,
                  itemBuilder: (context,index)=>Column(
                    children: [
                      Text(cuacaModel[index].kota),
                      Text(cuacaModel[index].suhu),
                      Text(cuacaModel[index].diniHari),
                      Text(cuacaModel[index].pagi),
                      Text(cuacaModel[index].siang),
                      Divider()
                    ],
                  ),
                ),
              ):Text("None")
            ),

          ],
        ),

      ),
    );
    throw UnimplementedError();
  }

}
