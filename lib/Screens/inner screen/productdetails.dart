import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yehia/Widgets/SubtitleTextWidget.dart';
import 'package:yehia/Widgets/namewidget.dart';
import 'package:yehia/Widgets/title%20widget.dart';
import 'package:yehia/provider/homeprovider.dart';
import 'package:yehia/provider/medicineprovider.dart';



class ProductDetailsScreen extends StatefulWidget {
  static const routName = "/ProductDetailsScreen";
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final productsProvider = Provider.of<PlaceProvider>(context);
    final getCurrProduct = productsProvider.findByProdId(productId!);
    // final productsProvider = Provider.of<Homeprovider>(context);
    // String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    // final getCurrProduct = productsProvider.findByProdId(productId!);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        // automaticallyImplyLeading: false,
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: getCurrProduct.PlaceImage,
              height: size.height * 0.38,
              width: double.infinity,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Title:${getCurrProduct.name}',
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SubtitleTextWidget(
                    label:'active:${getCurrProduct.activeingredient}',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SubtitleTextWidget(
                 label:"diagnosis: ${getCurrProduct.diagnosis}",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(

                    children: [

                      SubtitleTextWidget(
                          label:  "sideeffects:${getCurrProduct.sideeffects}",
                      ),
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}