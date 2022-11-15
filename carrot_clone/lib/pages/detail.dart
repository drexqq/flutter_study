// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_clone/components/manner_temperature.dart';
import 'package:flutter/material.dart';

class DetailContentView extends StatefulWidget {
  final Map<String, String> data;
  const DetailContentView({super.key, required this.data});

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  late Size deviceSize;
  late List<Map<String, String>> imgList;
  late int _curPage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    deviceSize = MediaQuery.of(context).size;
    imgList = [
      {"id": "0", "url": widget.data["image"]!},
      {"id": "1", "url": widget.data["image"]!},
      {"id": "2", "url": widget.data["image"]!},
      {"id": "3", "url": widget.data["image"]!},
      {"id": "4", "url": widget.data["image"]!},
    ];
    _curPage = 0;
  }

  PreferredSizeWidget _appBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
      ],
    );
  }

  // Render Hero Widget for Images
  Stack _setSliderImage() {
    return Stack(children: [
      Hero(
          tag: widget.data["cid"]!,
          child: CarouselSlider(
            items: imgList
                .map((data) => Image.asset(
                      data["url"]!,
                      width: deviceSize.width,
                      fit: BoxFit.fill,
                    ))
                .toList(),
            options: CarouselOptions(
              height: deviceSize.width,
              initialPage: 0,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _curPage = index;
                });
              },
            ),
          )),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((data) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _curPage == int.parse(data["id"]!)
                        ? Colors.white
                        : Colors.white.withOpacity(0.4)),
              );
            }).toList(),
          ))
    ]);
  }

  // Render UserInfo
  Widget _setSellerInfo() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
              radius: 25,
              backgroundImage: Image.asset("assets/images/user.png").image),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "판매자1122",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "제주시 도담동",
                )
              ],
            ),
          ),
          Expanded(child: MannerTemperature(mMannerTemperature: 37.5))
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return Column(
      children: [_setSliderImage(), _setSellerInfo()],
    );
  }

  Widget _bottomNavWidget() {
    return Container(
      width: deviceSize.width,
      height: 55,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavWidget(),
    );
  }
}
