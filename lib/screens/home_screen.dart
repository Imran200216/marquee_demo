import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// list of stacks
  final listOfStacks = [
    "assets/images/flutter.svg",
    "assets/images/java.svg",
    "assets/images/kotlin.svg",
    "assets/images/react.svg",
    "assets/images/swift.svg",
    "assets/images/unity.svg",
    "assets/images/vue.svg"
  ];

  /// scroll controller
  final _controller = ScrollController();

  late Timer _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timer) {
      start();
    });
    super.initState();
  }

  /// start functionality
  void start() {
    _timer = Timer.periodic(
      Duration(milliseconds: 100),
      (timer) {
        if (_controller.hasClients) {
          final maxScroll = _controller.position.maxScrollExtent;
          final currentScroll = _controller.offset;

          // Reset to start when reaching the end
          if (currentScroll >= maxScroll) {
            _controller.jumpTo(0);
          } else {
            _controller.animateTo(
              currentScroll + 20,
              duration: Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        centerTitle: true,
        title: Text("Custom Home Screen"),
        titleTextStyle: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      body: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: listOfStacks.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 30,
          );
        },
        itemBuilder: (context, index) {
          return Center(
            child: SizedBox(
              height: 140,
              width: 140,
              child: SvgPicture.asset(
                listOfStacks[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
