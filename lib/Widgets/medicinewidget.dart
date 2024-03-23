import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yehia/Screens/inner%20screen/productdetails.dart';
import 'package:yehia/Widgets/title%20widget.dart';
import 'package:yehia/model/medicine%20model.dart';
import 'package:yehia/provider/medicineprovider.dart';



class MedicineWidget extends StatefulWidget {
  const MedicineWidget({
    super.key,
    required this.productId, required this.placeModel,
  });
  final String productId;
  final Placemodel placeModel;
  @override
  State<MedicineWidget> createState() => _MedicineWidgetState();
}

class _MedicineWidgetState extends State<MedicineWidget> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<PlaceProvider>(context);
    final getCurrProduct = productsProvider.findByProdId(widget.productId);
    Size size = MediaQuery.of(context).size;

    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
           Navigator.pushNamed(
            context,
            ProductDetailsScreen.routName,
            arguments: getCurrProduct.PlaceId,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FancyShimmerImage(
                imageUrl: getCurrProduct.PlaceImage,
                height: size.height * 0.22,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: TitlesTextWidget(
                label:'Title:${getCurrProduct.name}',
                fontSize: 18,
                maxLines: 2,
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: TitlesTextWidget(
                label:'active:${getCurrProduct.activeingredient}',
                fontSize: 18,
                maxLines: 2,
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "diagnosis: ${getCurrProduct.diagnosis}",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                  fontSize: 15
              ),

              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                "sideeffects:${getCurrProduct.sideeffects}",style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                  fontSize: 15
              ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}