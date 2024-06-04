import 'dart:convert';
import 'dart:developer';

import 'package:api_youtube/models/model_class.dart';
import 'package:api_youtube/services/http_connection.dart';
import 'package:api_youtube/widget/tile_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpConnection instance = HttpConnection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api'),
      ),
      body: FutureBuilder<List<Welcome>>(
        future: instance.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TileWidget(fetchData: snapshot.data ?? []);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(children: [
                const Text('Failed to load data. Check connection'),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        instance.getData();
                      });
                    },
                    child: const Text('Retry'))
              ]),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data found'),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
