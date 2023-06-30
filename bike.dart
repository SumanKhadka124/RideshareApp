import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as Directions;

class GetBike extends StatefulWidget {
  @override
  State<GetBike> createState() => _GetBikeState();
}

class _GetBikeState extends State<GetBike> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(27.671849, 85.320408);

  TextEditingController _locationAController = TextEditingController();
  TextEditingController _locationBController = TextEditingController();

  Set<Polyline> _polylines = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getDirections() async {
    if (_locationAController.text.isEmpty ||
        _locationBController.text.isEmpty) {
      // Ensure both location inputs are provided
      return;
    }

    final directions = Directions.GoogleMapsDirections(
      apiKey: 'YOUR_API_KEY', // Replace with your actual API key
    );
    final response = await directions.directionsWithLocation(
      Directions.Location(
        lat: _center.latitude,
        lng: _center.longitude,
      ),
      Directions.Location(
        lat: double.tryParse(_locationAController.text) ?? 0.0,
        lng: double.tryParse(_locationBController.text) ?? 0.0,
      ),
    );

    if (response.isOkay) {
      final route = response.routes!.first;
      final polylinePoints = PolylinePoints();
      final List<PointLatLng> polylineResult =
          polylinePoints.decodePolyline(route.overviewPolyline!.points);

      final List<LatLng> polylineCoordinates = [];
      for (var point in polylineResult) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.blue,
            width: 5,
          ),
        );
      });

      final bounds = route.bounds;
      final cameraUpdate = CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(bounds.southwest.lat, bounds.southwest.lng),
          northeast: LatLng(bounds.northeast.lat, bounds.northeast.lng),
        ),
        50,
      );
      mapController.animateCamera(cameraUpdate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: 105.0,
            child: Center(
              child: Text(
                "Choose location",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.0),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // _scaffoldKey.currentState.openDrawer();
                        },
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // print("your menu action here");
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _locationAController,
                          decoration: InputDecoration(
                            hintText: "Location A",
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _locationBController,
                          decoration: InputDecoration(
                            hintText: "Location B",
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _getDirections,
                        child: Text("GO"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              polylines: _polylines,
            ),
          ),
        ],
      ),
    );
  }
}
