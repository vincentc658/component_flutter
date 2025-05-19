import 'package:flutter/material.dart';
import '../constant/constants_color.dart';
import 'empty_data_screen.dart';

class SearchableDropdown extends StatefulWidget {
  final List<DropdownOptionModel> items;
  final DropdownOptionModel? selectedValue;
  final Function(DropdownOptionModel) onChanged;
  final String hintText;

  const SearchableDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    this.hintText = "Select item",
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  late TextEditingController searchController;
  List<DropdownOptionModel> filteredItems = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredItems = widget.items;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _openDropdownDialog() {
    final query = searchController.text.toLowerCase();
    filteredItems =
        widget.items
            .where(
              (item) => item.codificationName.toLowerCase().contains(query),
            )
            .toList();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setModalState) {
                // Reassign the listener to call setModalState
                searchController.addListener(() {
                  final query = searchController.text.toLowerCase();
                  final newFiltered =
                      widget.items
                          .where(
                            (item) => item.codificationName
                                .toLowerCase()
                                .contains(query),
                          )
                          .toList();
                  setModalState(() {
                    filteredItems = newFiltered;
                  });
                });
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Text(
                        "Select",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ConstantsColor.PRIMARY.shade800,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white70,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: ConstantsColor.PRIMARY.shade300, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child:
                            filteredItems.isEmpty
                                ? EmptyDataScreen(
                                  message: 'Search Result Empty',
                                )
                                : ListView.separated(
                                  controller: scrollController,
                                  itemCount: filteredItems.length,
                                  separatorBuilder:
                                      (_, __) => Divider(
                                        color: Colors.grey[300],
                                        height: 0,
                                      ),
                                  itemBuilder: (context, index) {
                                    final item = filteredItems[index];
                                    final isSelected =
                                        widget
                                            .selectedValue
                                            ?.codificationName ==
                                        item.codificationName;
                                    return ListTile(
                                      title: Text(
                                        '${item.id} - ${item.codificationName}',
                                        style: TextStyle(
                                          fontWeight:
                                              isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                          color:
                                              isSelected
                                                  ? ConstantsColor.PRIMARY
                                                  : Colors.black87,
                                        ),
                                      ),
                                      trailing:
                                          isSelected
                                              ? const Icon(
                                                Icons.check_circle,
                                                color: ConstantsColor.PRIMARY,
                                              )
                                              : null,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      onTap: () {
                                        widget.onChanged(item);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openDropdownDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.selectedValue != null
                    ? '${widget.selectedValue!.id} - ${widget.selectedValue!.codificationName}'
                    : widget.hintText,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      widget.selectedValue == null
                          ? Colors.grey
                          : Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Icon(Icons.search),
          ],
        ),
      ),
    );
  }
}
class DropdownOptionModel{
  String id;
  String codificationName;
  DropdownOptionModel({
    required this.id,
    required this.codificationName,
  });
}
