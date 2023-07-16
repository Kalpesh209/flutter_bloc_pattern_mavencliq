// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mavencliq/Ui_Config/text_style.dart';
// import 'package:mavencliq/Ui_config/app_colors.dart';

// class SelectDomainItemWidget extends StatefulWidget {
//   final List<String> items;
//   const SelectDomainItemWidget({
//     Key? key,
//     required this.items,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _MultiSelectState();
// }

// class _MultiSelectState extends State<SelectDomainItemWidget> {
//   final List<String> _selectedItems = [];

//   void _itemChange(String itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         _selectedItems.add(itemValue);
//       } else {
//         _selectedItems.remove(itemValue);
//       }
//     });
//   }

//   void _cancel() {
//     Navigator.pop(context);
//   }

//   void _submit() {
//     print(_selectedItems);
//     Navigator.pop(context, _selectedItems);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [

//         Row(children: [

//            Text(
//               'Item',
//               style: MavenTextStyles.nunitoSemiBold.copyWith(
//                 fontSize: 14.sp,
//                 color: AppColors.kWelcomeBackColor,
//               ),
//             ),

//              Checkbox(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(2.r),
//               ),
//               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               checkColor: AppColors.kWhiteColor,
//               activeColor: AppColors.kSelectedTabColor,
//               value: widget.items.map((e) => null),
//               onChanged: (value) {
//                 _itemChange(item, isChecked!);
//                 setState(() {
//                   isChecked = value!;
//                 });
//                 // if (isChecked == true) {
//                 //   selectedItemList.addAll();
//                 //   // selectedItemList.add(widget.itemName);

//                 //   print('ADDED ITEM LIST : $selectedItemList');
//                 //   // setState(() {
//                 //   //   widget.newSelectedItemList = selectedItemList;
//                 //   //   print('SELECTED ITEM : ${widget.newSelectedItemList}');
//                 //   // });
//                 // } else {
//                 //   selectedItemList.remove(widget.itemName);
//                 //   // setState(() {
//                 //   //   widget.newSelectedItemList.remove(widget.itemName);
//                 //   // });

//                 //   print('DESELECTED ITEM: ${selectedItemList}');
//                 // }
//               },
//             ),

//         ],)
//         // Row(
//         //   children: widget.items
//         //       .map(
//         //         (item) => CheckboxListTile(
//         //           value: _selectedItems.contains(item),
//         //           title: Text(item),
//         //           controlAffinity: ListTileControlAffinity.leading,
//         //           onChanged: (isChecked) => _itemChange(item, isChecked!),
//         //         ),
//         //       )
//         //       .toList(),
//         // ),
//         // ListBody(
//         //   children: widget.items
//         //       .map(
//         //         (item) => CheckboxListTile(
//         //           value: _selectedItems.contains(item),
//         //           title: Text(item),
//         //           controlAffinity: ListTileControlAffinity.leading,
//         //           onChanged: (isChecked) => _itemChange(item, isChecked!),
//         //         ),
//         //       )
//         //       .toList(),
//         // ),
//         Divider(
//           color: AppColors.kTextFieldBorderColor,
//           thickness: 1,
//         ),
//       ],
//     );
//   }
// }
