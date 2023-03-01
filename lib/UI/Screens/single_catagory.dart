import 'package:flutter/material.dart';
import 'package:saver/widgets/app_text.dart';

import '../../Models/catagory_model.dart';
import '../../Models/item_model.dart';
import '../Components/heading_widget.dart';
import '../Components/item_widget.dart';
import '../Components/seperator_widget.dart';

class SingleCatagoryScreen extends StatelessWidget {
  const SingleCatagoryScreen({super.key, required this.catagory});
  final Map<CatagoryModel, List<ItemModel>> catagory;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
            backgroundColor: Colors.white,

            iconTheme: const IconThemeData(color: Colors.black),
            title: AppText(catagory.keys.first.name, bold: true,)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HeadingWidget(text: catagory.keys.first.name),
                // const SeperatorWidget(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: catagory[catagory.keys.first]!.length,
                  itemBuilder: (context, itemIndex) {
                    ItemModel item = catagory[catagory.keys.first]![itemIndex];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // HeadingWidget(text: item.name),
                          ItemWidget(
                            model: item,
                            screenSize: screenSize,
                            heading: item.name,

                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
