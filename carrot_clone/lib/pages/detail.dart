import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_clone/components/manner_temperature.dart';
import 'package:carrot_clone/models/content_model.dart';
import 'package:carrot_clone/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailContentView extends StatefulWidget {
  final Map<String, String> data;
  const DetailContentView({super.key, required this.data});

  @override
  State<DetailContentView> createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView>
    with SingleTickerProviderStateMixin {
  late ContentModel contentModel;

  late Size deviceSize;
  late List<Map<String, String>> imgList;
  late int _curPage;
  late final ScrollController _controller;
  double scrollPositionToAplha = 0;
  late final AnimationController _animationController;
  late final Animation appbarBtnColor;
  late bool isMyFavorite;
  final scaffoleKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    contentModel = ContentModel();
    _controller = ScrollController();
    _animationController = AnimationController(vsync: this);
    appbarBtnColor = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _controller.addListener(() {
      setState(() {
        scrollPositionToAplha =
            _controller.offset > 255 ? 255 : _controller.offset;

        _animationController.value = scrollPositionToAplha / 255;
      });
    });
    isMyFavorite = false;
    _setMyFavoriteContent();
  }

  void _setMyFavoriteContent() async {
    bool ck =
        await contentModel.isMyFavoriteContent(widget.data["cid"] as String) ??
            false;
    setState(() {
      isMyFavorite = ck;
    });
  }

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

  Widget _setIconColor(IconData icon) {
    return AnimatedBuilder(
      animation: appbarBtnColor,
      builder: (context, child) => Icon(
        icon,
        color: appbarBtnColor.value,
      ),
    );
  }

  PreferredSizeWidget _appBarWidget() {
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scrollPositionToAplha.toInt()),
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: _setIconColor(Icons.arrow_back),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: _setIconColor(Icons.share)),
        IconButton(onPressed: () {}, icon: _setIconColor(Icons.more_vert)),
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

  Widget _line() {
    return Container(
      height: 1,
      color: Colors.grey.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.data["title"]!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Text(
            "디지털/가전 22시간 전",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "너무 잘 보고있습니다 대략 6~8번째 영상이 조금 어려웠지만 계속 하는중 입니당너무 잘 보고있습니다 대략 6~8번째 영상이 조금 어려웠지만 계속 하는중 입니당너무 잘 보고있습니다 대략 6~8번째 영상이 조금 어려웠지만 계속 하는중 입니당너무 잘 보고있습니다 대략 6~8번째 영상이 조금 어려웠지만 계속 하는중 입니당너무 잘 보고있습니다 대략 6~8번째 영상이 조금 어려웠지만 계속 하는중 입니당",
            style: TextStyle(fontSize: 15, height: 1.5),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "채팅 3 관심 17 조회 295",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _otherCellContents() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "판매자님의 판매 상품",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            "모두보기",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          _setSliderImage(),
          _setSellerInfo(),
          _line(),
          _contentDetail(),
          _line(),
          _otherCellContents()
        ])),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate(List.generate(
                20,
                (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey,
                            height: 120,
                          ),
                        ),
                        const Text("상품 제목", style: TextStyle(fontSize: 14)),
                        const Text("금액",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    )).toList()),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          ),
        )
      ],
    );
  }

  Widget _bottomNavWidget() {
    return Container(
        width: deviceSize.width,
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                if (isMyFavorite) {
                  await contentModel
                      .deleteMyFavoriteContent(widget.data["cid"] as String);
                } else {
                  await contentModel.addMyFavoriteContent(widget.data);
                }
                setState(() {
                  isMyFavorite = !isMyFavorite;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        isMyFavorite ? "관심목록에 추가됐습니다." : "관심목록에서 제거되었습니다."),
                    duration: const Duration(milliseconds: 1000),
                  ));
                });
              },
              child: SvgPicture.asset(
                isMyFavorite
                    ? "assets/svgs/heart_on.svg"
                    : "assets/svgs/heart_off.svg",
                width: 20,
                height: 20,
                color: const Color(0xfff08f4f),
              ),
            ),
            Container(
              width: 1,
              height: 40,
              margin: const EdgeInsets.only(left: 15, right: 15),
              color: Colors.grey.withOpacity(0.3),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DataUtils.calcWon(widget.data["price"]!),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "가격 제안 불가",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xfff08f4f),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  child: const Text(
                    "채팅으로 거래하기",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoleKey,
      extendBodyBehindAppBar: true,
      appBar: _appBarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavWidget(),
    );
  }
}
