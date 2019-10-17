import 'package:flutter/material.dart';
import 'package:wools/widgets/images_widget.dart';

class PacketRain extends StatefulWidget {
  @override
  _PacketRainState createState() => _PacketRainState();
}

class _PacketRainState extends State<PacketRain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/packet_rain/bg.png',), fit: BoxFit.cover)
        ),
      )
    );
  }
}
