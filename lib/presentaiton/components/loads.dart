import 'package:altek/presentaiton/components/load_details.dart';
import 'package:flutter/material.dart';

class LoadsPage extends StatefulWidget {
  const LoadsPage({Key? key}) : super(key: key);

  @override
  State<LoadsPage> createState() => _LoadsPageState();
}

class _LoadsPageState extends State<LoadsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Last update - 1 min ago',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadDetails(),
                        ),
                      ),
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.circle_outlined,
                                  size: 20,
                                  color: Color(0xFFDCDCDC),
                                ),
                                Icon(
                                  Icons.more_vert,
                                  size: 20,
                                  color: Color(0xFF272727),
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 26,
                                  color: Color(0xFFDCDCDC),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 1,
                                  bottom: 3,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Warrington, PA',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF272727),
                                          ),
                                        ),
                                        Text(
                                          'Received 59 min ago',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            color: Color(0xFF333333),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Midland, TX',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF272727),
                                          ),
                                        ),
                                        Text(
                                          '321 mi',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Color(0xFF333333),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
