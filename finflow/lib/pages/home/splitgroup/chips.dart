import 'package:finflow/utils/Colors/colors.dart';
import 'package:flutter/material.dart';

class ListOfChips extends StatefulWidget {
  final Function(List<String>) onFiltersChanged;
  final List<String> filters;
  final bool firstselected;
  const ListOfChips(
      {Key? key,
      required this.onFiltersChanged,
      required this.filters,
      required this.firstselected})
      : super(key: key);

  @override
  State<ListOfChips> createState() => _ListOfChipsState();
}

class _ListOfChipsState extends State<ListOfChips> {
  late List<String> selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = widget.firstselected ? [widget.filters[0]] : [];
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemCount: widget.filters.length,
        itemBuilder: (context, index) {
          final filter = widget.filters[index];
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
