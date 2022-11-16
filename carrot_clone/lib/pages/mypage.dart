import 'package:carrot_clone/models/content_model.dart';
import 'package:carrot_clone/pages/detail.dart';
import 'package:carrot_clone/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late ContentModel contentModel;

  @override
  void initState() {
    super.initState();
    contentModel = ContentModel();
  }

  PreferredSizeWidget _appBarWidget() {
    return AppBar(
      title: const Text(
        "관심목록",
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Future<List<dynamic>> _loadMyFavoriteContentList() async {
    return await contentModel.loadFavoriteContent() ?? [];
  }

  Widget _setDataList(List<dynamic>? datas) {
    int size = datas! == [] ? 0 : datas.length;
    return size == 0
        ? const Center(child: Text("관심목록이 없습니다."))
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
                                DataUtils.calcWon(datas[index]["price"]!),
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
    return FutureBuilder<List<dynamic>>(
        future: _loadMyFavoriteContentList(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
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
