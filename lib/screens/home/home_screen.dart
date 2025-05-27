import 'package:delivery_client/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:delivery_client/screens/restaurant/restaurant_detail_screen.dart'; // Import detail screen
// import 'package:delivery_client/widgets/home/restaurant_card_skeleton.dart'; // For loading state
// import 'package:delivery_client/widgets/home/restaurant_card.dart'; // For actual data

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true; // Simulate loading state
  String _deliveryAddress = "123 Main Street, Anytown"; // Mock address

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await _fetchData();
  }

  void _editAddress() {
    // Placeholder for address editing logic
    print("Edit address tapped");
    // Example: Show a dialog or navigate to an address selection screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Address"),
        content: TextFormField(
          initialValue: _deliveryAddress,
          onChanged: (value) {
            // temp storage, not saved until "Save"
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              // setState(() { _deliveryAddress = newAddress; }); // Update address
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // No back button for home tab
        titleSpacing: kDefaultPadding,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("DELIVER TO", style: theme.textTheme.labelSmall?.copyWith(color: kNeutralWhiteColor.withOpacity(0.8))),
            GestureDetector(
              onTap: _editAddress,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _deliveryAddress,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: kNeutralWhiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: kDefaultPadding / 4),
                  const Icon(Icons.edit_outlined, size: 16, color: kNeutralWhiteColor),
                  const SizedBox(width: kDefaultPadding / 2), // Space before search bar
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: kNeutralWhiteColor),
            // Badge can be added here using a Stack or a package like `badges`
            onPressed: () {
              // Navigate to notifications screen
              print("Notification bell tapped");
            },
          ),
          const SizedBox(width: kDefaultPadding / 2),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + kDefaultPadding / 2), // Adjust height as needed
          child: Padding(
            padding: const EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search restaurants or dishes",
                hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
                  color: kNeutralDarkGrayColor.withOpacity(0.7),
                ),
                prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                filled: true,
                fillColor: kNeutralWhiteColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: kDefaultPadding),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadiusButton), // More rounded
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadiusButton),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadiusButton),
                  borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
                ),
              ),
              onTap: () {
                // Navigate to Search Screen or show search overlay
                print("Search bar tapped");
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
              },
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: theme.primaryColor,
        child: CustomScrollView(
          slivers: <Widget>[
            // Quick Filters Section
            SliverToBoxAdapter(
              child: Container(
                height: 60, // Adjust height as needed
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  children: <Widget>[
                    _buildFilterChip(context, "Open Now", isToggle: true),
                    _buildFilterChip(context, "Italian"),
                    _buildFilterChip(context, "Chinese"),
                    _buildFilterChip(context, "Mexican"),
                    _buildFilterChip(context, "Fast Delivery"),
                    _buildFilterChip(context, "Highly Rated"),
                    _buildFilterChip(context, "\$"),
                    _buildFilterChip(context, "\$\$"),
                    _buildFilterChip(context, "\$\$\$"),
                  ],
                ),
              ),
            ),

            // Restaurant Cards Section
            _isLoading
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
                        // child: RestaurantCardSkeleton(), // Placeholder for skeleton
                        child: Text("Loading Skeleton..."),
                      ),
                      childCount: 5, // Number of skeleton loaders
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // Replace with actual RestaurantCard widget and data
                        // For now, using mock restaurant IDs from MockRestaurantRepositoryImpl
                        final mockRestaurantIds = ["restaurant1", "restaurant2", "restaurant3"];
                        final restaurantId = mockRestaurantIds[index % mockRestaurantIds.length];
                        final restaurantName = restaurantId == "restaurant1"
                            ? "Italiano Delight"
                            : restaurantId == "restaurant2"
                            ? "Dragon Wok"
                            : "Taco Fiesta";

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kDefaultPadding / 2,
                          ),
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.restaurant, size: 40),
                              title: Text('$restaurantName (ID: ${index + 1})'),
                              subtitle: Text('Cuisine Type - 4.x stars\n~30 min - \$X.XX fee - Status'),
                              trailing: const Icon(Icons.favorite_border),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RestaurantDetailScreen(restaurantId: restaurantId),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      childCount: 10, // Number of restaurants
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, {bool isToggle = false}) {
    // Basic chip, will need state management for selection
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: RawChip(
        label: Text(label),
        labelStyle: Theme.of(context).chipTheme.labelStyle,
        selectedColor: Theme.of(context).chipTheme.selectedColor,
        backgroundColor: Theme.of(context).chipTheme.backgroundColor,
        // selected: _selectedFilters.contains(label), // Needs state
        onSelected: (selected) {
          // Handle filter selection
          print("$label filter selected: $selected");
        },
        showCheckmark: isToggle ? false : null, // No checkmark for toggles like "Open Now"
        avatar: isToggle
            ? Icon(Icons.toggle_on_outlined, color: Theme.of(context).primaryColor)
            : null, // Example for toggle
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 1.5, vertical: kDefaultPadding / 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusButton),
          side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.3)),
        ),
      ),
    );
  }
}
