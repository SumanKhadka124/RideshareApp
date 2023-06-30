import 'package:flutter/material.dart';

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FoodPage(),
    );
  }
}

class FoodPage extends StatelessWidget {
  FoodPage({Key? key}) : super(key: key);

  final List<String> imagePaths = [
    'assets/1.jpg',
    'assets/2.jpeg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('BHATBHATE FOODS'),
              background: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              // child: Center(
              //   child: Text('Scroll to the menu'),
              //),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 300.0,
                  child: Image.asset(
                    imagePaths[index % imagePaths.length],
                    fit: BoxFit.cover,
                  ),
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
