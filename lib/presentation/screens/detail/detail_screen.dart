import 'package:flutter/material.dart';
import 'package:test_app/domain/entities/advertisements_entity.dart';

class DetailScreen extends StatelessWidget {

  static const path = '/detail';
  static const name = 'detail-screen';

  final AdvertisementsEntity data;

  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          data.title,
          style: const TextStyle(
            fontSize: 20
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Hero(
              tag: data.id,
              child: SizedBox(
                width: 400,
                child: Image.asset(data.imageUrl),
              ),
            ),
          ),
        ],
      )
    );
  }
}