import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_app/config/constants/utils.dart';
import 'package:test_app/domain/entities/advertisements_entity.dart';
import 'package:test_app/infraestructure/mappers/advertisement_mapper.dart';
import 'package:test_app/presentation/providers/advertisement/advertisement_provider.dart';
import 'package:test_app/presentation/screens/detail/detail_screen.dart';
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
      context.read<AdvertisementProvider>().initScrollController();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
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
          _TypeAdvertisements(advertisementProvider: advertisementProvider),
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
    return const SizedBox();
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          context.push(DetailScreen.path, extra: {
            "item": data
          });
        },
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Hero(
                  tag: data.id,
                  child: SizedBox(
                    width: 100,
                    height: 80,
                    child: Image.asset(data.imageUrl),
                  ),
                ),
                const SizedBox(width: 20,),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(data.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                          const Spacer(),
                          Text(Utils.intToPrice(data.price))
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Text(data.description, maxLines: 2, style: const TextStyle(overflow: TextOverflow.ellipsis),)
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

class _TypeAdvertisements extends StatelessWidget {
  
  final AdvertisementProvider advertisementProvider;

  const _TypeAdvertisements({
    required this.advertisementProvider,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: advertisementProvider.typeSelected == null 
                    ? null 
                    : advertisementProvider.typeSelected! == AdvertisementType.phones
                    ? const WidgetStatePropertyAll(Colors.blue) 
                    : null
                  ),
                  onPressed: (){
                    advertisementProvider.setTypeSelected(AdvertisementType.phones);
                  }, 
                  child: Center(
                    child: Text(
                      'Telefonos',
                      style: TextStyle(color: advertisementProvider.typeSelected == null 
                      ? Colors.black 
                      : advertisementProvider.typeSelected! == AdvertisementType.phones 
                      ? Colors.white 
                      : Colors.black),
                    ),
                  ),
                )
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: advertisementProvider.typeSelected == null 
                    ? null 
                    : advertisementProvider.typeSelected! == AdvertisementType.laptops 
                    ? const WidgetStatePropertyAll(Colors.blue) 
                    : null
                  ),
                  onPressed: (){
                    advertisementProvider.setTypeSelected(AdvertisementType.laptops);
                  }, 
                  child: Center(
                    child: Text(
                      'Laptops',
                      style: TextStyle(color: advertisementProvider.typeSelected == null 
                      ? Colors.black 
                      : advertisementProvider.typeSelected! == AdvertisementType.laptops 
                      ? Colors.white 
                      : Colors.black),
                    ),
                  ),
                )
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: advertisementProvider.typeSelected == null 
                    ? null 
                    : advertisementProvider.typeSelected! == AdvertisementType.smartWatchs 
                    ? const WidgetStatePropertyAll(Colors.blue) 
                    : null
                  ),
                  onPressed: (){
                    advertisementProvider.setTypeSelected(AdvertisementType.smartWatchs);
                  }, 
                  child: Center(
                    child: Text(
                      'Smart Watch\'s',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: advertisementProvider.typeSelected == null 
                      ? Colors.black 
                      : advertisementProvider.typeSelected! == AdvertisementType.smartWatchs 
                      ? Colors.white 
                      : Colors.black),
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}