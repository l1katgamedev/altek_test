import 'dart:async';

import 'package:altek/presentaiton/components/loads.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? connection;
  bool isOffline = false;
  int _selectedIndex = 1;
  bool _switchValue = false;
  bool _showMap = false;
  double _value = 20;

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  final TextEditingController _searchController = TextEditingController();

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
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          isOffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        setState(() {
          isOffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        setState(() {
          isOffline = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        setState(() {
          isOffline = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        setState(() {
          isOffline = false;
        });
      }
    });
    super.initState();
    currentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    connection!.cancel();
    super.dispose();
  }

  Future<bool?> _showModalBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 30,
                      ),
                      RichText(
                        textDirection: TextDirection.ltr,
                        text: const TextSpan(
                          text: 'Location',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Warrington, PA 189232',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text('300mi'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.access_time_filled_outlined,
                        color: Colors.blue,
                        size: 30,
                      ),
                      RichText(
                        textDirection: TextDirection.ltr,
                        text: const TextSpan(
                          text: 'Availability time at',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text('Now'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Switch.adaptive(
                        value: _switchValue,
                        onChanged: (value) {
                          setState(() {
                            _switchValue = value;
                          });
                        },
                      ),
                      RichText(
                        textDirection: TextDirection.ltr,
                        text: TextSpan(
                          text: 'Available',
                          style: TextStyle(
                            fontSize: 20,
                            color: _switchValue == true ? const Color(0xFF27AE60) : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          children: const [
                            TextSpan(
                              text: ' ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(''),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      return _switchValue;
    });
  }

  Future<double?> _showModalSearchBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: 260,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Enter zip code or city',
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text('Radius of position:'),
                          Text('300mi'),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: CupertinoSlider(
                            min: 0.0,
                            max: 100.0,
                            value: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
            );
          });
        }).then((value) {
      return _value;
    });
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
      _showModalBottomSheet().then((value) {
        if (value != null) {
          setState(() {
            _switchValue = value;
          });
        }
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
    const LoadsPage(),
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
        leading: GestureDetector(
          onTap: () => _showModalSearchBottomSheet(),
          child: const Icon(
            Icons.search,
            color: Color(0xFF272727),
          ),
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
          ? isOffline == true
              ? Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 30),
                  color: Colors.transparent,
                  //red color on offline, green on online
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "No Internet Connection",
                    style: TextStyle(fontSize: 20, color: Color(0xFF272727)),
                  ),
                )
              : Center(child: _pages.elementAt(_selectedIndex))
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers.toSet(),
              zoomControlsEnabled: true,
              myLocationButtonEnabled: false,
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
          : const SizedBox(),
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
