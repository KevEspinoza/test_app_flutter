import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/presentation/providers/advertisement/advertisement_provider.dart';

class HomeScreen extends StatefulWidget {

  static const name = 'home-screen';
  static const path = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<AdvertisementProvider>().getAdvertisement(1);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buscador Anuncio',
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ),
      body: const Column(
        children: [
          _TypeAdvertisements()
        ],
      ),
    );
  }
}

class _TypeAdvertisements extends StatelessWidget {

  const _TypeAdvertisements();

  @override
  Widget build(BuildContext context) {

    final noSelectedDecoration = BoxDecoration(
      border: Border.all(color: Colors.black)
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: noSelectedDecoration,
                height: 48,
                child: const Center(
                  child: Text(
                    'Laptops'
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: noSelectedDecoration,
                height: 48,
                child: const Center(
                  child: Text(
                    'Telefonos'
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: noSelectedDecoration,
                height: 48,
                child: const Center(
                  child: Text(
                    'Relojes'
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}