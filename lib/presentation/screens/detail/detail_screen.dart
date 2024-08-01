import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/config/constants/utils.dart';
import 'package:test_app/domain/entities/advertisements_entity.dart';
import 'package:test_app/presentation/screens/screens.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: Image.asset(data.imageUrl),
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Row(
                    children: [
                      Text(data.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24),),
                      const Spacer(),
                      const Icon(Icons.star, color: Colors.red,),
                      const Text('4.8', style: TextStyle(fontWeight: FontWeight.w500),),
                      const SizedBox(width: 4,),
                      Text('${data.totalReviews} reviews', style: const TextStyle(color: Colors.black38),),
                    ],
                  ),
                  Row(
                    children: [
                      Text(Utils.intToPrice(data.price), style: const TextStyle(fontSize: 16),),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: (){
              
                        }, 
                        child: const Text('Mapa')
                      )
                    ],
                  ),
                  const SizedBox(height: 24,),
                  Text(data.description)
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
                context.push(SellerDetailScreen.path);
              }, 
              child: const Text('Contactar Vendedor')
            )
          ],
        ),
      )
    );
  }
}