import 'package:api_youtube/services/http_connection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/model_class.dart';

class SecondPage extends StatefulWidget {
  SecondPage({super.key, required this.idNum});
  final int idNum;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Future<Welcome> fetchData;

  @override
  void initState() {
    super.initState();
    fetchData = HttpConnection().getOne(widget.idNum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<Welcome>(
          future: fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(children: [
                  const Text('Failed to load data. Check connection'),
                  ElevatedButton(onPressed: () {}, child: const Text('Retry'))
                ]),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${data.id}. ${data.title}',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data.body,
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No data found'),
              );
            }
          },
        ),
      ),
    );
  }
}
