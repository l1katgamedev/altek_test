import 'dart:async';

import 'package:altek/presentaiton/components/bottom_sheet_available.dart';
import 'package:altek/presentaiton/components/loads.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  bool _switchValue = false;
  bool _showMap = false;

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(33.6844, 73.0479),
      infoWindow: InfoWindow(title: 'qwe'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    currentLocation();
  }

  currentLocation() {
    getUserCurrentLocation().then((value) async {
      _markers.add(
        Marker(
          markerId: const MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'My current position'),
        ),
      );

      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BottomSheetAvailable(
              switchValue: _switchValue,
              valueChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
              },
            );
          }).then((value) {
        setState(() {
          _switchValue = value;
        });
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {});

    return await Geolocator.getCurrentPosition();
  }

  static final List<Widget> _pages = [
    const Icon(
      Icons.wallet,
      size: 150,
    ),
    LoadsPage(),
    const Icon(
      Icons.call,
      size: 150,
    ),
    const Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  static const List<String> _titles = [
    'Loads',
    'Loads',
    'Orders',
    'Driver',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _titles.elementAt(_selectedIndex),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF272727),
          ),
        ),
        leading: const Icon(
          Icons.search,
          color: Color(0xFF272727),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_showMap == false) {
                    _showMap = true;
                  } else {
                    _showMap = false;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: _showMap == false ? Colors.transparent : const Color(0xFF272727),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.map_outlined,
                  color: _showMap == false ? const Color(0xFF272727) : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _showMap == false
          ? Center(child: _pages.elementAt(_selectedIndex))
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers.toSet(),
              zoomControlsEnabled: true,
              myLocationButtonEnabled: true,
            ),
      floatingActionButton: _showMap == true
          ? FloatingActionButton(
              onPressed: currentLocation,
              backgroundColor: const Color(0xFF272727),
              child: const Icon(
                Icons.gps_fixed,
                color: Colors.white,
              ),
            )
          : Text(''),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF272727),
        unselectedItemColor: Colors.grey[500],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch.adaptive(
                  value: _switchValue,
                  onChanged: (value) {},
                ),
              ),
            ),
            label: 'Available',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.square_outlined,
            ),
            label: 'Loads',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.drive_eta),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Driver',
          ),
        ],
      ),
    );
  }
}
