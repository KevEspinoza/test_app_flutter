import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/domain/entities/advertisements_entity.dart';
import 'package:test_app/presentation/providers/advertisement/advertisement_provider.dart';
import 'package:test_app/widgets/shared/snackbar.dart';

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
      context.read<AdvertisementProvider>().getAdvertisement();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final advertisementProvider = context.watch<AdvertisementProvider>();

    advertisementProvider.onErrorCallback = (message){
      if(message.isEmpty)return;
      BasicSnackBar().showSnackBar(context, message, Colors.red, Icons.close);
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buscador Anuncio',
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ),
      body: advertisementProvider.isLoading 
      ? const Center(
          child: CircularProgressIndicator(),
        ) 
      : Column(
        children: [
          const _TypeAdvertisements(),
          const _SearchBar(),
          advertisementProvider.advertisementData.isEmpty 
          ? const _EmptyState() 
          : Expanded(
            child: _AdvertisementList(
              data: advertisementProvider.advertisementData,
              controller: advertisementProvider.scrollController,
            )
          ),
          advertisementProvider.isLoadingPage
          ? const SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
          : const SizedBox(),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 120,
      child: Placeholder(),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 120,
      child: Placeholder(),
    );
  }
}

class _AdvertisementList extends StatelessWidget {

  final List<AdvertisementsEntity> data;
  final ScrollController controller;

  const _AdvertisementList({
    required this.data,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];

        return _AdvertisementItem(
          data: item
        );
      },
    );
  }
}

class _AdvertisementItem extends StatelessWidget {

  final AdvertisementsEntity data;

  const _AdvertisementItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Text(data.title),
          Text(data.price.toString()),
          Text('${data.description.substring(0, 14)}...')
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