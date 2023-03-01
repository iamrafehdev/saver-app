// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// import '../../Controllers/item_controller.dart';
// import '../../Models/catagory_model.dart';
// import '../../Models/item_model.dart';
// import '../Components/heading_widget.dart';
// import '../Components/item_widget.dart';
// import '../Components/seperator_widget.dart';

// class CatagoryScreen extends StatelessWidget {
//   const CatagoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ItemController>(
//       builder: (controller) => FutureBuilder(
//           future: controller.getAllItems(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(child: Text("no data"));
//             } else if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             List<Map<CatagoryModel, List<ItemModel>>> data = snapshot.data!;

//             if (data.isEmpty) {
//               return const Center(child: Text("No data Found"));
//             }
//             return ListView.builder(
//               itemCount: data.length,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               itemBuilder: (context, catgoryIndex) => Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     HeadingWidget(text: data[catgoryIndex].keys.first.name),
//                     ItemTotalWidget(
//                       leading: controller
//                           .gettotalForCatagory(catgoryIndex)
//                           .totalSavedAmount
//                           .toStringAsFixed(1),
//                       trailing: controller
//                           .gettotalForCatagory(catgoryIndex)
//                           .totalInflatedAmount
//                           .toStringAsFixed(1),
//                       progress: controller
//                           .gettotalForCatagory(catgoryIndex)
//                           .totalProgress,
//                     ),
//                     const SizedBox(height: 10),
//                     const HeadingWidget(text: "items"),
//                     const SeperatorWidget(),
//                     ListView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: data[catgoryIndex]
//                                 [data[catgoryIndex].keys.first]!
//                             .length,
//                         itemBuilder: (context, itemIndex) {
//                           ItemModel item = data[catgoryIndex]
//                               [data[catgoryIndex].keys.first]![itemIndex];
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 HeadingWidget(text: item.name),
//                                 ItemWidget(
//                                   model: item,
//                                 ),
//                               ],
//                             ),
//                           );
//                         })
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
