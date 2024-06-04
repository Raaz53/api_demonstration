import 'dart:developer';

import 'package:api_youtube/display/second_page.dart';
import 'package:api_youtube/models/model_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.fetchData,
  });

  final List<Welcome> fetchData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fetchData.length,
        itemBuilder: (context, int index) {
          final singleData = fetchData[index];
          if (fetchData.isEmpty) {
            return const Center(
              child: Text('The list is empty'),
            );
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondPage(
                            idNum: fetchData[index].id,
                          )));
            },
            child: Card(
              child: ListTile(
                title: Text('${singleData.id}. ${fetchData[index].title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  fetchData[index].body,
                  maxLines: 3,
                ),
              ),
            ),
          );
        });
  }
}
