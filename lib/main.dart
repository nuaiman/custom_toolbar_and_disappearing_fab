import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double top = 0;

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Image.network(
                    'https://images.pexels.com/photos/3566120/pexels-photo-3566120.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
                    fit: BoxFit.cover,
                  ),
                  title: LayoutBuilder(
                    builder: (ctx, cons) {
                      top = cons.biggest.height;
                      return AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: top <= 200 ? 1.0 : 0.0,
                        child: Row(
                          children: [
                            SizedBox(width: 12),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260'),
                            ),
                            SizedBox(width: 12),
                            Text('Fluttercraft')
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 50,
                    itemBuilder: (ctx, i) {
                      return FlutterLogo();
                    }),
              ),
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    double defaultMargin = Platform.isIOS ? 270 : 250;
    double defaultStart = 230;
    double defaultEnd = defaultStart / 2;

    double top = defaultMargin;
    double scale = 1.0;

    if (_scrollController.hasClients) {
      double offSet = _scrollController.offset;
      top -= offSet;

      if (offSet < defaultMargin - defaultStart) {
        scale = 1;
      } else if (offSet < defaultMargin - defaultEnd) {
        scale = (defaultMargin - defaultEnd - offSet) / defaultEnd;
      } else {
        scale = 0;
      }
    }

    return Positioned(
      top: top,
      right: 20,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.camera),
        ),
      ),
    );
  }
}
