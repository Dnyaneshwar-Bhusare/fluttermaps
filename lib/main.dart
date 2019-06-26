import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;
  String searchAddr;
 
    var _currentMapType;
    bool mapTogle = false;
  

  @override
  Widget build(BuildContext context) {

  
        return Scaffold(
            body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: onMapCreated,
              mapType: _currentMapType,
              
          initialCameraPosition: CameraPosition(
            target: LatLng(19.717369,77.149368),
            zoom: 16.0,
          ),
        ),
        Positioned(
          top: 30.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: menu,
                    iconSize: 30.0,
                  ),
                  hintText: 'Enter Address',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: searchandNavigate,
                      iconSize: 30.0)),
              onChanged: (val) {
                setState(() {
                  searchAddr = val;
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment:Alignment.bottomRight,
            child: FloatingActionButton(
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onPressed: changeMapType,
                           
                            child: const Icon(Icons.map, size: 36.0),
                          ),
                        ),
                      )
                    ],
                  ));
                }
              
                searchandNavigate() {
                  Geolocator().placemarkFromAddress(searchAddr).then((result) {
                    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                        target:LatLng(result[0].position.latitude, result[0].position.longitude),
                        zoom: 10.0)));
                  });
                }
              
                void onMapCreated(controller) {
                  setState(() {
                    mapController = controller;
                  });
                }
              
                void menu() {
              
                }
              
                void changeMapType() {
                  setState(() {
   _currentMapType = _currentMapType == MapType.normal
        ? MapType.satellite
        : MapType.normal;
});

  }
}
