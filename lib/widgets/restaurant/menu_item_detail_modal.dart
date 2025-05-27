import 'package:flutter/material.dart';
import 'package:delivery_client/models/menu_item_model.dart';
import 'package:delivery_client/utils/constants.dart';

class MenuItemDetailModal extends StatefulWidget {
  final MenuItem menuItem;

  const MenuItemDetailModal({super.key, required this.menuItem});

  @override
  State<MenuItemDetailModal> createState() => _MenuItemDetailModalState();
}

class _MenuItemDetailModalState extends State<MenuItemDetailModal> {
  int _quantity = 1;
  // String? _selectedSize; // Example for customization
  // List<String> _selectedAddons = []; // Example for customization
  final TextEditingController _specialInstructionsController = TextEditingController();

  double get _totalPrice {
    // Basic price, add customization logic here
    return widget.menuItem.price * _quantity;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  void dispose() {
    _specialInstructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.85, // Adjust height as needed
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: theme.canvasColor, // Use theme's canvas color for bottom sheet
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kBorderRadiusStandard * 2),
          topRight: Radius.circular(kBorderRadiusStandard * 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Close button and Item Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.menuItem.name,
                  style: theme.textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
            ],
          ),
          const SizedBox(height: kDefaultPadding / 2),

          // Large Item Image
          if (widget.menuItem.imageUrl != null)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kBorderRadiusStandard),
                child: Image.network(
                  widget.menuItem.imageUrl!,
                  height: screenHeight * 0.25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: screenHeight * 0.25,
                    color: kNeutralLightGrayColor,
                    child: const Icon(Icons.broken_image, size: 60),
                  ),
                ),
              ),
            ),
          const SizedBox(height: kDefaultPadding),

          // Description
          if (widget.menuItem.description != null)
            Text(widget.menuItem.description!, style: theme.textTheme.bodyMedium),
          const SizedBox(height: kDefaultPadding),

          // Price (already part of total price at bottom)
          // Text('\$${widget.menuItem.price.toStringAsFixed(2)}', style: theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor)),
          // const SizedBox(height: kDefaultPadding),
          Expanded(
            child: ListView(
              // For scrollable customization options
              children: [
                // Customization Options (Placeholder)
                // Text("Size", style: theme.textTheme.titleMedium),
                // RadioListTile(title: Text("Small"), value: "small", groupValue: _selectedSize, onChanged: (val) => setState(()=> _selectedSize = val)),
                // RadioListTile(title: Text("Medium"), value: "medium", groupValue: _selectedSize, onChanged: (val) => setState(()=> _selectedSize = val)),
                // RadioListTile(title: Text("Large"), value: "large", groupValue: _selectedSize, onChanged: (val) => setState(()=> _selectedSize = val)),
                // const SizedBox(height: kDefaultPadding),
                // Text("Add-ons", style: theme.textTheme.titleMedium),
                // CheckboxListTile(title: Text("Extra Cheese (\$1.00)"), value: _selectedAddons.contains("cheese"), onChanged: (val) => setState(()=> val! ? _selectedAddons.add("cheese") : _selectedAddons.remove("cheese"))),
                // CheckboxListTile(title: Text("Bacon (\$1.50)"), value: _selectedAddons.contains("bacon"), onChanged: (val) => setState(()=> val! ? _selectedAddons.add("bacon") : _selectedAddons.remove("bacon"))),
                // const SizedBox(height: kDefaultPadding),
                Text("Special Instructions", style: theme.textTheme.titleMedium),
                const SizedBox(height: kDefaultPadding / 2),
                TextFormField(
                  controller: _specialInstructionsController,
                  decoration: const InputDecoration(
                    hintText: "e.g., no onions, extra spicy",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),

          // Quantity Selector & Add to Cart Button
          const SizedBox(height: kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _decrementQuantity,
                    color: theme.primaryColor,
                  ),
                  Text('$_quantity', style: theme.textTheme.titleLarge),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _incrementQuantity,
                    color: theme.primaryColor,
                  ),
                ],
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Add item to cart logic
                    print('Added ${widget.menuItem.name} x$_quantity to cart. Total: \$$_totalPrice');
                    Navigator.of(context).pop(); // Close modal after adding
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 0.75),
                  ),
                  child: Text('Add to Cart - \$${_totalPrice.toStringAsFixed(2)}'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showMenuItemDetailModal(BuildContext context, MenuItem menuItem) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Important for taller bottom sheets
    backgroundColor: Colors.transparent, // Make modal background transparent
    builder: (BuildContext context) {
      return MenuItemDetailModal(menuItem: menuItem);
    },
  );
}
