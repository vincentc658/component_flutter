import 'package:flutter/material.dart';
import 'package:research_component/component/formField/dropdown_option.dart';
import '../../constant/constants_color.dart';
import '../../constant/constants_styling.dart';
import 'form_field_config.dart';

class InputFieldSearchDropdown extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final IconData? icon;
  final bool isRequired;
  final bool isShowId;
  final bool isShowLabel;
  final TextInputType keyboardType;
  final List<DropdownOption> items;
  DropdownOption? selectedValue;
  final Function(DropdownOption) onChanged;
  final TextEditingController controller;

  InputFieldSearchDropdown({
    Key? key,
    required FormFieldConfig fieldConfig,
    required this.onChanged,
    required this.controller,
    required this.isShowId,
    this.selectedValue,
    this.errorText,
  }) : label = fieldConfig.labelField,
       hintText = fieldConfig.hint,
       helperText = fieldConfig.helper,
       icon = fieldConfig.icon,
       items = fieldConfig.dropdownOptions ?? [],
       isRequired = fieldConfig.isRequired,
        isShowLabel = fieldConfig.isShowLabel,
       keyboardType = fieldConfig.keyboardType ?? TextInputType.text,
       super(key: key);

  @override
  State<InputFieldSearchDropdown> createState() =>
      _InputFieldSearchDropdownState();
}

class _InputFieldSearchDropdownState extends State<InputFieldSearchDropdown> {
  late List<DropdownOption> filteredItems;
  late DropdownOption? selectedValue;
  TextEditingController? searchController;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    searchController = TextEditingController();
    selectedValue = widget.selectedValue; // simpan nilai awal
  }

  void _openDropdownDialog() {
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
                searchController?.addListener(() {
                  final query = searchController?.text.toLowerCase();
                  final results =
                      widget.items.where((item) {
                        return item.name.toLowerCase().contains(query ?? '');
                      }).toList();
                  setModalState(() {
                    filteredItems = results;
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
                          enabledBorder: ConstantsStyling.enabledBorder,
                          focusedBorder: ConstantsStyling.focusedBorder,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child:
                            filteredItems.isEmpty
                                ? Center(child: Text("No results found."))
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
                                        selectedValue?.name == item.name;
                                    return ListTile(
                                      title: Text(
                                        widget.isShowId
                                            ? '${item.id} - ${item.name}'
                                            : item.name,
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
                                        print("${item.id} ${item.name}");
                                        setState(() {
                                          selectedValue = item;
                                          widget.controller?.text =
                                              widget.isShowId
                                                  ? '${item.id} - ${item.name}'
                                                  : item.name;
                                        });
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
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if(widget.isShowLabel)
                  Text(
                    widget.label!,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: ConstantsColor.PRIMARY.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (widget.isRequired && widget.isShowLabel)
                    const Text(
                      "*",
                      style: TextStyle(fontSize: 14, color: Colors.red),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        TextField(
          readOnly: true,
          onTap: _openDropdownDialog,
          controller: widget.controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
            hintText: widget.hintText ?? 'Select an option',
            suffixIcon: const Icon(Icons.search, color: ConstantsColor.PRIMARY),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            border: ConstantsStyling.enabledBorder,
            enabledBorder: ConstantsStyling.enabledBorder,
            focusedBorder: ConstantsStyling.focusedBorder,
            errorBorder: ConstantsStyling.errorBorder,
            errorText: widget.errorText,
          ),
        ),

        if (widget.helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.helperText!,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
        const SizedBox(height: 18),
      ],
    );
  }
}
