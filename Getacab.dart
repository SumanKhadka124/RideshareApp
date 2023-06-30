// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class GetACabPage extends StatefulWidget {
  const GetACabPage({super.key});
  @override
  State<GetACabPage> createState() => _GetACabPageState();
}

class _GetACabPageState extends State<GetACabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 233, 196),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Get a Cab'),
            floating: true,
            snap: true,
            // Add other properties as needed, such as elevation, background color, etc.
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      child: Image.network(
                        'https://images.squarespace-cdn.com/content/v1/5d87fde87a683e29b483f4a3/1612884108912-TCOJ9M5COMYOI2LFY18L/DF_YT_TH_How+To+Film+Cars.jpg?format=1500w',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Container(
                      height: 200,
                      child: Image.network(
                        'https://d3kjluh73b9h9o.cloudfront.net/original/3X/9/4/945b99cf4c4f196f5f620a5d58d69a5e8c862be0.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
