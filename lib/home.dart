import 'package:consult_app/bottom_bar.dart';
import 'package:consult_app/pages/login.dart';
import 'package:consult_app/pages/account.dart';
import 'package:consult_app/pages/chat.dart';
import 'package:consult_app/pages/main_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late int CurrentPage;

  late TabController tabcontroller;
  @override
  void initState() {
    tabcontroller = TabController(length: 3, vsync: this);
    CurrentPage = 1;
    tabcontroller.animation!.addListener(() {
      final value = tabcontroller.animation!.value.round();
      if (value != CurrentPage && mounted) {
        changePage(value);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  void changePage(int nextPage) {
    setState(() {
      CurrentPage = nextPage;
    });
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                  width: size.width,
                  height: size.height * 0.4,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('lib/photos/consult.jpg')))),
            ),
            Positioned(
              bottom: 0,
              child: Center(
                  child: ClipPath(
                clipper: BackgroundClipper(),
                child: Container(
                    padding: const EdgeInsets.only(right: 30),
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: size.width,
                    height: size.height * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 150, left: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get Started",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Let's connect with",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("each other",
                                style: Theme.of(context).textTheme.headline1),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        "Consult your memeory and passion to know\n",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                TextSpan(
                                    text: "what matters to you the most",
                                    style:
                                        Theme.of(context).textTheme.bodyText1)
                              ])),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                minWidth: size.width * 0.9,
                                height: 50,
                                color: Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3,
                                        color:
                                            Theme.of(context).backgroundColor),
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => BottomBar(
                                            end: 2,
                                            start: 10,
                                            selectedColor: Theme.of(context)
                                                .colorScheme
                                                .onTertiary,
                                            unselectedColor: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            currentPage: CurrentPage,
                                            bottomtabcontroller: tabcontroller,
                                            barcolor: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            child: TabBarView(
                                                controller: tabcontroller,
                                                physics: PageScrollPhysics(),
                                                dragStartBehavior:
                                                    DragStartBehavior.down,
                                                children: [
                                                  Main(),
                                                  Chat(),
                                                  Account()
                                                ]),
                                          )));
                                },
                                child: Text(
                                  "Explore",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                minWidth: size.width * 0.9,
                                padding: const EdgeInsets.all(0),
                                height: 50,
                                elevation: 0,
                                color: Theme.of(context).backgroundColor,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Login()));
                                },
                                child: Text(
                                  "Get Started",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyText2,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              )),
            )
          ],
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.33 + 300 * 0.3);
    path.quadraticBezierTo(
        size.width, size.height * 0.33, size.width - 150, size.height * 0.33);
    // width is the start of the curve and the height is the end of the curve
    path.quadraticBezierTo(0, size.height * 0.33, 0, size.height * 0.33 - 100);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
