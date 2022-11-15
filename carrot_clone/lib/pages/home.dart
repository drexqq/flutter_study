import 'package:carrot_clone/models/content_model.dart';
import 'package:carrot_clone/pages/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ContentModel contentModel;
  final Map<String, String> locationType = {
    "ara": "아라동",
    "ora": "오라동",
    "donam": "도남동"
  };
  late String _curLoc;

  @override
  void initState() {
    super.initState();
    _curLoc = "ara";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    contentModel = ContentModel();
  }

  final intl = NumberFormat("#,###", "ko_KR");
  String calcWon(String price) =>
      num.tryParse(price) != null ? "${intl.format(int.parse(price))}원" : price;

  PreferredSizeWidget _appBarWidget() {
    return AppBar(
      title: GestureDetector(
        child: PopupMenuButton<String>(
          offset: const Offset(-5, 25),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              1),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: "ara",
                child: Text("아라동"),
              ),
              const PopupMenuItem(
                value: "ora",
                child: Text("오라동"),
              ),
              const PopupMenuItem(
                value: "donam",
                child: Text("도남동"),
              )
            ];
          },
          onSelected: (String place) {
            setState(() {
              _curLoc = place;
            });
          },
          child: Row(
            children: [
              Text(locationType[_curLoc]!),
              const Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      ),
      elevation: 1,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svgs/bell.svg",
              width: 22,
            )),
      ],
    );
  }

  Future<List<Map<String, String>>> _loadContent() async {
    List<Map<String, String>> res = await contentModel.loadContentData(_curLoc);
    return res;
  }

  Widget _setDataList(List<Map<String, String>> datas) {
    int size = datas == [] ? 0 : datas.length;
    return size == 0
        ? Center(child: Text("No data in $_curLoc"))
        : ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DetailContentView(data: datas[index])));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Hero(
                            tag: datas[index]["cid"]!,
                            child: Image.asset(
                              datas[index]["image"]!,
                              width: 100,
                              height: 100,
                            ),
                          )),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  datas[index]["title"]!,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(datas[index]["location"]!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.3))),
                              ),
                              Text(
                                calcWon(datas[index]["price"]!),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svgs/heart_off.svg",
                                      width: 13,
                                      height: 13,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(datas[index]["likes"]!),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 1, color: Colors.black.withOpacity(0.4));
            },
            itemCount: size,
          );
  }

  Widget _bodyWidget() {
    return FutureBuilder<List<Map<String, String>>>(
        future: _loadContent(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, String>>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("데이터 오류"));
          }
          return _setDataList(snapshot.data ?? []);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }
}
