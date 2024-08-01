import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/presentation/providers/seller/seller_provider.dart';
import 'package:test_app/widgets/shared/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerDetailScreen extends StatefulWidget {

  static const path = '/seller/detail';

  static const name = 'seller-detail';

  const SellerDetailScreen({super.key});

  @override
  State<SellerDetailScreen> createState() => _SellerDetailScreenState();
}

class _SellerDetailScreenState extends State<SellerDetailScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<SellerProvider>().clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final sellerProvider = context.watch<SellerProvider>();

    sellerProvider.onErrorCallback = (message){
      if(message.isEmpty)return;
      BasicSnackBar().showSnackBar(context, message, Colors.red, Icons.close);
    };

    sellerProvider.isValidCallback = () async{
      final Uri params = Uri(
        scheme: 'mailto',
        path: 'kevin_280700@hotmail.com',
        query: 'subject=${sellerProvider.data}', 
      );
      if (await canLaunchUrl(params)) {
        await launchUrl(params);
      } else {
        if(!context.mounted) return;
        BasicSnackBar().showSnackBar(context, 'Error al enviar correo', Colors.red, Icons.close);
      }
    };

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          'Detalle Anuncio',
          style: TextStyle(
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
                  const Center(
                    child: CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 40,),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Align(
                    alignment: Alignment.center,
                    child: Text('John Smith')
                  ),
                  const SizedBox(height: 8,),
                  GestureDetector(
                    onTap: () async{
                      await launchUrl(Uri.parse('tel://6674948390'));
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 8,),
                        Text('Call -> 6674948390')
                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                  const Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 8,),
                      Text('Email')
                    ],
                  ),
                  const SizedBox(height: 8,),
                  const Text('Nombre'),
                  TextField(
                    onChanged: (value){
                      context.read<SellerProvider>().onNameChange(value);
                    },
                  ),
                  const SizedBox(height: 8,),
                  const Text('Correo contacto'),
                  TextField(
                    onChanged: (value){
                      context.read<SellerProvider>().onEmailChange(value);
                    } 
                  ),
                  const SizedBox(height: 8,),
                  const Text('Texto correo'),
                  TextField(
                    maxLines: 5,
                    maxLength: 100,
                    onChanged: (value){
                      context.read<SellerProvider>().onDataChange(value);
                    } 
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: (){
                  context.read<SellerProvider>().checkFormsValid();
                }, 
                child: const Text('Enviar correo')
              ),
            )
          ],
        )
      )
    );
  }
}