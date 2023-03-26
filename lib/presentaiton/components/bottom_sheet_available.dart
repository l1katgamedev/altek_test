import 'package:flutter/material.dart';

class BottomSheetAvailable extends StatefulWidget {
  final bool switchValue;
  final ValueChanged valueChanged;

  const BottomSheetAvailable({Key? key, required this.switchValue, required this.valueChanged}) : super(key: key);

  @override
  State<BottomSheetAvailable> createState() => _BottomSheetAvailableState();
}

class _BottomSheetAvailableState extends State<BottomSheetAvailable> {
  late bool _switchValue;

  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
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
          Container(
            width: MediaQuery.of(context).size.width,
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
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                    }),
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
      ),
    );
  }
}
