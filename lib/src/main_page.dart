import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_bin_flutter/src/home_page/home_page.dart';
import 'package:smart_bin_flutter/src/qr_page/qr_page.dart';
import 'package:smart_bin_flutter/widget/ui/color.dart';

class MainPage extends StatefulWidget {
  static const routeName = "MainPage";
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;
  bool camera = true;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    setState(() {
      currentIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            HomePage(),
            QrPage(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 76,
          color: white,
          alignment: Alignment.topCenter,
          child: TabBar(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            indicator: BoxDecoration(),
            dividerColor: transparent,
            controller: tabController,
            tabAlignment: TabAlignment.center,
            tabs: <Widget>[
              Tab(
                child: currentIndex == 0
                    ? SvgPicture.asset('assets/svg/home.svg')
                    : SvgPicture.asset('assets/svg/homeunselect.svg'),
              ),
              Tab(
                child: currentIndex == 1
                    ? SvgPicture.asset('assets/svg/tabqr.svg')
                    : SvgPicture.asset('assets/svg/tabunselect.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
