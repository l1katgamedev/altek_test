import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slider_button/slider_button.dart';

class LoadDetails extends StatefulWidget {
  const LoadDetails({Key? key}) : super(key: key);

  @override
  State<LoadDetails> createState() => _LoadDetailsState();
}

class _LoadDetailsState extends State<LoadDetails> {
  TextEditingController _priceController = TextEditingController();
  TextEditingController _mileController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Google Plex'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(37.42796133580664, -122.085749655962),
  );

  static const CameraPosition _kLake = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 19.151926040649414,
  );

  static final Marker _kLakeMarker = Marker(
    markerId: const MarkerId('_kLake'),
    infoWindow: const InfoWindow(title: 'Lake'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: const LatLng(37.43296265331129, -122.08832357078792),
  );

  static final Polyline _kPolyline = const Polyline(
    polylineId: PolylineId('_kPolyline'),
    width: 5,
    points: [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
    ],
  );

  static final Polygon _kPolygon = const Polygon(
    polygonId: PolygonId('_kPolygon'),
    strokeWidth: 2,
    fillColor: Colors.transparent,
    points: [
      LatLng(37.42796133580664, -122.085749655962),
      LatLng(37.43296265331129, -122.08832357078792),
    ],
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _mileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F5F9),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Load #1312',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF272727),
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF272727),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                '59 min ago',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const Icon(
              Icons.access_time,
              color: Color(0xFF272727),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          polygons: {_kPolygon},
          polylines: {_kPolyline},
          markers: {_kGooglePlexMarker, _kLakeMarker},
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false,
        ),
        bottomSheet: BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            return Container(
              height: 390,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7F7F7F),
                          ),
                        ),
                        Text(
                          'Per mile',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7F7F7F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 190,
                            child: TextField(
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              controller: _priceController,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF272727),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFE0E0E0),
                                prefixIcon: Icon(
                                  Icons.attach_money,
                                  color: Color(0xFF9A9A9A),
                                  size: 30,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF9A9A9A),
                                ),
                                hintText: '523',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3),
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            height: 100,
                            width: 190,
                            child: TextField(
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              controller: _mileController,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF272727),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFE0E0E0),
                                prefixIcon: Icon(
                                  Icons.attach_money,
                                  color: Color(0xFF9A9A9A),
                                  size: 30,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF9A9A9A),
                                ),
                                hintText: '3,22',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFD3D3D3),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Market price: 523',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7F7F7F),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              '23 drivers placed bids',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF7F7F7F),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SliderButton(
                      shimmer: false,
                      backgroundColor: const Color(0xFF303030),
                      buttonColor: const Color(0xFF56BB62),
                      buttonSize: 70,
                      width: 350,
                      action: () {
                        Navigator.of(context).pop();
                      },
                      alignLabel: Alignment.center,
                      label: const Text(
                        "Place Bid",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 90,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFFE0E0E0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                'Chat',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF272727),
                                ),
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Color(0xFFFF5756),
                                child: Text(
                                  '2',
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFFE0E0E0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                'Call',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF272727),
                                ),
                              ),
                             Icon(
                               Icons.call_outlined,
                               size: 20,
                               color: Color(0xFF56BB62),
                             ),
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFFE0E0E0),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF272727),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
