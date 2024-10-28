import 'package:flutter/material.dart';
import 'package:locall/common/models/item_model.dart';

class CustomDropdown extends StatefulWidget {
  final List<ItemModel> items;
  final Function(ItemModel) onItemSelected;
  final bool isRequired;
  final String hint;
  const CustomDropdown({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.isRequired = false,
    required this.hint,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  ItemModel? _selectedItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<ItemModel>(
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                labelText: widget.hint,
                labelStyle: const TextStyle(color: Colors.grey),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              value: _selectedItem,
              isExpanded: true,
              items: widget.items.map((ItemModel item) {
                return DropdownMenuItem<ItemModel>(
                  value: item,
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
              validator: (value) {
                if (widget.isRequired == true && value == null) {
                  return "Please select the option";
                }
                return null;
              },
              onChanged: (ItemModel? newValue) {
                setState(() {
                  _selectedItem = newValue;
                });
                if (newValue != null) {
                  widget.onItemSelected(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
