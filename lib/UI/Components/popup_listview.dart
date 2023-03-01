import 'package:flutter/material.dart';

class PopupListView extends StatefulWidget {
  const PopupListView(
      {super.key, this.dropdownValues, required this.shouldIncludeSearchBar});
  final bool shouldIncludeSearchBar;
  final List<String>? dropdownValues;
  @override
  State<PopupListView> createState() => _PopupListViewState();
}

class _PopupListViewState extends State<PopupListView> {
  List<String>? searchedValues = [];
  TextEditingController cont = TextEditingController();
  FocusNode node = FocusNode();
  @override
  void initState() {
    super.initState();
    searchedValues = widget.dropdownValues;
    node.addListener(() {
      setState(() {});
    });
  }

  void search(String search) {
    if (search.isEmpty) {
      searchedValues = widget.dropdownValues;
    } else {
      searchedValues = widget.dropdownValues!
          .where(
              (element) => element.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100, maxHeight: 250),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26)),
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.shouldIncludeSearchBar)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cont,
                focusNode: node,
                decoration: const InputDecoration(hintText: "Search here"),
                onChanged: (value) {
                  search(value);
                },
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedValues!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                title: Text(searchedValues![index]),
                onTap: () => Navigator.pop(context, searchedValues![index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
