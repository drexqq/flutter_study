import 'package:flutter/material.dart';

class MannerTemperature extends StatelessWidget {
  final double mMannerTemperature;
  int? mLevel;
  static const List<Color> tempColors = [
    Color(0xff072038),
    Color(0xff0d3a65),
    Color(0xff186ec0),
    Color(0xff37b24d),
    Color(0xffffad13),
    Color(0xfff76707),
  ];

  MannerTemperature(
      {super.key, required this.mMannerTemperature, this.mLevel}) {
    _calcTempLevel();
  }
  void _calcTempLevel() {
    if (mMannerTemperature <= 20) {
      mLevel = 0;
    } else if (mMannerTemperature > 20 && mMannerTemperature <= 32) {
      mLevel = 1;
    } else if (mMannerTemperature > 32 && mMannerTemperature <= 36.5) {
      mLevel = 2;
    } else if (mMannerTemperature > 36.5 && mMannerTemperature < 40) {
      mLevel = 3;
    } else if (mMannerTemperature > 40 && mMannerTemperature < 50) {
      mLevel = 4;
    } else if (mMannerTemperature > 50) {
      mLevel = 5;
    }
  }

  double get temp => mMannerTemperature;

  Widget _setTempLabelWithBar() {
    return SizedBox(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$temp°C",
            style: TextStyle(
                color: tempColors[mLevel!],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 6,
              color: Colors.black.withOpacity(0.2),
              child: Row(
                children: [
                  Container(
                    height: 6,
                    width: 60 / 99 * mMannerTemperature,
                    color: tempColors[mLevel!],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _setTempLabelWithBar(),
            Container(
                margin: const EdgeInsets.only(left: 7),
                width: 30,
                height: 30,
                child: Image.asset("assets/images/level-$mLevel.jpg"))
          ],
        ),
        const Text(
          "매너온도",
          style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              decoration: TextDecoration.underline),
        )
      ],
    );
  }
}
