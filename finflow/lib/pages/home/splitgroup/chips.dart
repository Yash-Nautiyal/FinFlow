import 'package:finflow/utils/Colors/colors.dart';
import 'package:flutter/material.dart';

class ListOfChips extends StatefulWidget {
  final Function(List<String>) onFiltersChanged;

  const ListOfChips({Key? key, required this.onFiltersChanged})
      : super(key: key);

  @override
  State<ListOfChips> createState() => _ListOfChipsState();
}

class _ListOfChipsState extends State<ListOfChips> {
  List<String> filters = [
    'Trip',
    'Shopping',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  late List<String> selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = [];
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: FilterChip(
                onSelected: (value) {
                  setState(() {
                    if (selectedFilter.contains(filter)) {
                      selectedFilter.remove(filter);
                    } else {
                      selectedFilter.clear();
                      selectedFilter.add(filter);
                    }
                  });
                  widget.onFiltersChanged(selectedFilter);
                },
                selected: selectedFilter.contains(filter),
                side: BorderSide(color: grey),
                label: Text(
                  filter,
                  style: textTheme.displaySmall!.copyWith(
                    color:
                        selectedFilter.contains(filter) ? Colors.black : null,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
